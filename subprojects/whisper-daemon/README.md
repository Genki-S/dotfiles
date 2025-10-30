# Whisper Daemon

A Python web API server that uses OpenAI Whisper to transcribe microphone input.

## Features

- FastAPI web server with `/transcribe-mic` endpoint
- Configurable microphone selection by name
- Adjustable speech detection parameters
- Docker support with audio device access

## Environment Variables

- `MIC_NAME` - Microphone name (partial match, optional)
- `PORT` - Server port (default: 8000)
- `PAUSE_TIME` - Pause time before considering speech ended (default: 1.5s)
- `HALLUCINATE_THRESHOLD` - "Too quiet" threshold, higher = less sensitive (default: 400)

## Install as systemd service

Use `whisper-daemon.service`.

Also copy the env file and update as needed:

```
mkdir -p $HOME/.config/whisper-daemon
cp config.env.example $HOME/.config/whisper-daemon/config.env
```

## Running Locally

```bash
# Install dependencies
pip install -r requirements.txt

# Run with default settings
python main.py

# Or with custom settings
MIC_NAME="USB" PAUSE_TIME=2.0 python main.py
```

## Running with Docker

### Build and run manually:
```bash
docker build -t whisper-daemon .
docker run --rm -p 8000:8000 \
  --device /dev/snd:/dev/snd \
  --group-add audio \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -e DISPLAY=${DISPLAY} \
  -e MIC_NAME="USB" \
  whisper-daemon
```

### Using docker-compose:
```bash
# Run with default settings
docker-compose up

# Run with custom settings
MIC_NAME="USB" PAUSE_TIME=2.0 docker-compose up
```

## Audio Device Access in Docker

The Docker setup includes:
- Mount `/dev/snd` for audio device access
- Audio group permissions
- PulseAudio socket mounting (if available)
- X11 socket mounting for display access (required for pynput)
- Required audio system libraries

## API Usage

```bash
# Transcribe microphone input
curl -X POST http://localhost:8000/transcribe-mic
```

Returns:
```json
{"transcription": "your spoken text here"}
```
