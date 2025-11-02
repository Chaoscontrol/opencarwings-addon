# OpenCarwings Home Assistant Add-on

[![GitHub Release](https://img.shields.io/github/release/Chaoscontrol/opencarwings-addon.svg)](https://github.com/Chaoscontrol/opencarwings-addon/releases)
[![GitHub Activity](https://img.shields.io/github/commit-activity/y/Chaoscontrol/opencarwings-addon)](https://github.com/Chaoscontrol/opencarwings-addon/commits/main)

Home Assistant add-on for [OpenCarwings](https://github.com/developerfromjokela/opencarwings) - a Nissan CARWINGS-compatible server for bringing back Nissan TCUs and online services.

## Features

- **Remote A/C Control**: Start/stop climate control remotely
- **Charging Management**: Control EV charging schedules
- **Notifications**: Receive alerts from your Nissan vehicle
- **TCU Communication**: Direct communication with Nissan Telematics Control Units
- **Trip Data**: Access journey information and efficiency stats
- **Built-in Databases**: PostgreSQL and Redis included (no external setup required)
- **Automatic Updates**: Daily sync with upstream OpenCarwings repository

## Installation

### Prerequisites

- Home Assistant OS/Supervisor
- Nissan LEAF with CARWINGS-compatible TCU

### Add Repository

1. Open Home Assistant
2. Go to **Settings** → **Add-ons** → **Add-on Store**
3. Click the menu (⋮) → **Repositories**
4. Add: `https://github.com/Chaoscontrol/opencarwings-addon`
5. Click **Add** then **Close**

### Install Add-on

1. Find "OpenCarwings" in the add-on store
2. Click **Install**
3. Configure options (see below)
4. Click **Start**

## Configuration

### Main Options

| Option      | Description       | Default |
| ----------- | ----------------- | ------- |
| `timezone`  | System timezone   | `UTC`   |
| `log_level` | Logging verbosity | `info`  |

### Ports

- **8124**: Web UI (HTTP)
- **8125**: Web UI (HTTPS) - configure SSL certificates separately
- **55230**: TCU TCP Server

## Usage

### Web Interface

1. After starting the add-on, click **Open Web UI**
2. Create an admin account
3. Add your Nissan vehicle
4. Configure SMS gateway for TCU activation (optional)

### Vehicle Setup

1. Register your Nissan account in the web UI
2. Add your vehicle using VIN
3. Configure SMS activation (see TCU setup below)

### TCU Activation

The add-on communicates with Nissan TCUs via SMS activation:

1. Configure SMS provider in vehicle settings
2. TCU receives activation SMS
3. TCU connects to add-on's TCP server (port 55230)
4. Remote commands become available

## Development

### Repository Structure

```
opencarwings-addon/
├── opencarwings/           # Add-on files
│   ├── config.yaml        # Add-on configuration
│   ├── build.json         # Build settings
│   ├── Dockerfile         # Container build
│   ├── rootfs/           # Runtime files
│   └── CHANGELOG.md      # Version history
├── .github/workflows/    # CI/CD workflows
└── README.md             # This file
```

### Upstream Sync

The add-on automatically syncs with upstream OpenCarwings daily:

- Checks for new commits in `developerfromjokela/opencarwings`
- Updates Dockerfile to latest commit
- Generates changelog from commit messages
- Bumps add-on version
- Triggers rebuild

### Manual Patches

For add-on specific changes:

1. Modify files in `opencarwings/`
2. Push to trigger CI build
3. Test changes

## Troubleshooting

### Common Issues

**Add-on won't start:**

- Check logs in Home Assistant Supervisor
- Verify port conflicts (8080, 8443, 55230)
- Ensure sufficient disk space for databases

**TCU not connecting:**

- Verify SMS gateway configuration
- Check TCU compatibility
- Review add-on logs for connection attempts

**Database errors:**

- Add-on includes built-in PostgreSQL/Redis
- Data persists in `/data` directory
- Manual database reset: stop add-on, delete `/data/postgres` and `/data/redis`

### Logs

View logs through:

- Home Assistant Supervisor → Add-ons → OpenCarwings → Log
- Add-on web UI (if accessible)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes
4. Test thoroughly
5. Submit a pull request

## License

This add-on is licensed under MIT. The upstream OpenCarwings project has its own license.

## Links

- **Upstream Project**: [developerfromjokela/opencarwings](https://github.com/developerfromjokela/opencarwings)
- **Nissan TCU Protocol**: [nissan-leaf-tcu](https://github.com/developerfromjokela/nissan-leaf-tcu)
- **Home Assistant Add-ons**: [addons.community](https://addons.community)

## Support

- **Issues**: [GitHub Issues](https://github.com/Chaoscontrol/opencarwings-addon/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Chaoscontrol/opencarwings-addon/discussions)
- **Home Assistant Community**: Search for "OpenCarwings" in the forums
