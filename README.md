# server-temperature-guard
Guardian for water-cooled server. When temperature raises beyond a reasonable threshold, the server shutsdown.

# How it works

Just read the code. It is only 60 lines

# Dependency

sensor-lm, grep

# How to install

Run the script with root privilege using crontab

```crontab
1 * * * * /bin/bash /root/main.bash
```

If it does not work, try make it executable.

```bash
chmod +x main.bash
```