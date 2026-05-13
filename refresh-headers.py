import re
import subprocess
from datetime import datetime
from pathlib import Path

# nix run nixpkgs#python3 -- ./refresh-headers.py

def get_birthtime(file_path):
    try:
        cmd = ['stat', '-c', '%W', str(file_path)]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        
        timestamp = int(result.stdout.strip())
        
        if timestamp > 0:
            return datetime.fromtimestamp(timestamp).strftime('%Y-%m-%d')

    except (subprocess.CalledProcessError, ValueError):
        pass

    # fallback to last modified if birthtime is unavailable
    return datetime.fromtimestamp(file_path.stat().st_mtime).strftime('%Y-%m-%d')

def process_nix_files():
    # recursively find nix files starting from current directory
    base_path = Path.cwd()
    nix_files = list(base_path.rglob('*.nix'))
    
    if not nix_files:
        return

    # regex to find comment starting at the beginning of the file
    header_pattern = re.compile(r'^/\*.*?\*/\s*', re.DOTALL)

    for file_path in nix_files:
        try:
            content = file_path.read_text(encoding='utf-8')
            cleaned_content = header_pattern.sub('', content)
            
            creation_date = get_birthtime(file_path)
            
            rel_path = file_path.relative_to(base_path)
            new_header = (
                f"/*\n"
                f"  {rel_path}\n"
                f"\n"
                f"  part of nixos system\n"
                f"  created {creation_date}\n"
                f"*/\n\n"
            )
            
            file_path.write_text(new_header + cleaned_content, encoding='utf-8')
            print(f"Updated: {rel_path} [{creation_date}]")
            
        except Exception as e:
            print(f"Failed to process {file_path}: {e}")

if __name__ == "__main__":
    process_nix_files()