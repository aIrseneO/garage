
# Server: `sshd`
- Config: `/etc/ssh/sshd_config`
```bash
# Start a server
/usr/sbin/sshd -D
```

# Client: `ssh`
- Config: `/etc/ssh/ssh_config`
```bash
ssh -F config sshserver
ssh garage@127.0.0.1 -p 2222
```

