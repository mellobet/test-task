

# T1.B

## Oneliners: 

- sudo find / -type f -exec  du -Sh {} + | sort -hr | head -n 3

### Excluding /proc
- sudo find / -type f -not -path "/proc/*" -exec du -Sh {} + | sort -hr | head -n 3
