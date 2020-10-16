# Blinds Manager

This is a simple script to help manage blinds controlled by my [homie_blind_control](https://github.com/sillyfrog/homie_blind_control) firmware.

This provides integration with [Home Assistant](https://www.home-assistant.io/) using MQTT discovery.

When configured and running it will notify Home Assistant via MQTT about the configured devices, and allow controlling of your blinds via HA (open, close etc).

## Configuration

The configuration is done via JSON, in a file called `config.json` in the same directory as the `blindmanager` script. There is an example configuration that can be used as a template called `config.json-example`.

There are 2 top level keys, `host` and `blinds`. `host` is just the host name of the MQTT server to connect to to listen for messages and send updates.

`blinds` in a list object, which each element defining a blind. Each blind has the following fields:

-
- `name`: The name of the blind to show in Home Assistant
- `channel`: (optional), the channel of the blind on the remote, defaults to `1`
- `remote_id`: The HEX ID of the remote, if already paired, use the receiver function of the `homie_blind_control` to see what this is by subscribing to MQTT events (or in the Web UI for new Remote IDs), if there is no physical remote, this can be any 4 digit hex number
- `time_open`: The time it would take for the blind to open (in seconds), used to give a rough position to HA and allow setting of position (this is never going to be super accurate)
- `time_close`: As above for closing time, often different as gravity is helping
- `topic`: The topic to use when talking to HA, this _must_ be unique
- `homie_id`: The topic given to the `homie_blind_control` device when initially configured
- `device_class`: The HA [Device Class](https://www.home-assistant.io/integrations/cover/) for this cover, defaults to `shade`

## Running

Once a valid `config.json` has been created, run the script. If not running in Docker, it will required Python 3.7 and the [PAHO MQTT](https://pypi.org/project/paho-mqtt/) module to be installed. The included `Dockerfile` shows how I build and run the script.

When it loads for the first time, all required `homeassistant/*` topics will be published for HA to discover the blinds. Communication on the HA side is done with a MQTT topic base of `blinds/*`. It will also subscribe to the relevant `homie/*` topics to know the status of the blinds, and to publish events to.
