# Simple Antivirus

A simple shell-script antivirus project for Ubuntu 

The antivirus periodically monitors a directory,checks files when changes are detected
,and moves files flagged as malware to the qurantine dir.
A separate restore script lets the user restore or permanently delete quarantined files.

# Project Structure

Example folder hierarchy:

``` text
9409-lab2/
├── antivirusd.sh
├── restore.sh
├── Makefile
├── README.md
└── dirs/
    ├── MalcFolder/     # Directory monitored by antivirus
    └── Quarantine/     # Directory malicious files
```


# Prerequisites

-   Ubuntu or (any Linux distribution)
-   shell (`/bin/sh`).
-   Standard command-line utilities used by the scripts
-   `make` to use the Makefile.

Install `make` on Ubuntu

``` sh
sudo apt update
sudo apt install make
```

# Detection Rules

The required detection lists are defined in `antivirusd.sh`:

-   **Flagged extensions:** `.exe`, `.bat`, `.vbs`, `.scr`, `.ps1`
-   **Flagged content keywords:** `virus`, `trojan`, `malware`, `worm`,
    `ransomware`

A file is treated as malicious if
its extension matches the flagged-extension list **or** its content
contains one of the listed keywords.

When a file is detected,it prints a message, copies the file
into the quarantine directory using its original filename, and removes
the original from the monitored directory.

# Running the Antivirus

The script accepts three arguments:

``` text
antivirusd.sh <source-directory> <quarantine-directory> <interval-seconds>
```

Make the script executable:

``` sh
chmod +x antivirusd.sh
```

Run it by replacing the example paths with the paths on your
machine:

``` sh
./antivirusd.sh "./antivirusd.sh /home/bigo/antivirus/9409-lab2/dirs/MalcFolder /home/bigo/antivirus/9409-lab2/dirs/Quarantine 5

```

Antivirus performs an initial scan, then checks the source directory at
the configured interval. Keep the terminal open while it runs. Stop it
with `Ctrl+C`.

# Using the Restore Tool

The restore script accepts the source directory and quarantine
directory:

``` text
restore.sh <source-directory> <quarantine-directory>
```

Make it executable:

``` sh
chmod +x restore.sh
```

Run it with the same directories used by the daemon:

``` sh
./restore.sh /home/bigo/antivirus/9409-lab2/dirs/MalcFolder /home/bigo/antivirus/9409-lab2/dirs/Quarantine
```

The script lists quarantined files and asks you to choose one. The
available actions are:

1.  **Restore** --- move the selected file back to the source directory.
2.  **Permanently delete** --- remove the selected file from quarantine.
3.  **Leave as-is** --- keep the file in quarantine

Enter `0` at the file-selection prompt to exit. The antivirus daemon and
restore tool should not be run at the same time!!!.

## Using the Makefile

If the Makefile defines the required targets, use:

``` sh
make
```

to run the target configured as the default, and:

``` sh
make restore
```

to run the restore target.

Check the target names and configured directory paths in your
`Makefile`; they must match the actual names and paths in your project.
