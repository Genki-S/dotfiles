import os
import sys
from fastapi import FastAPI
from whisper_mic import WhisperMic
import speech_recognition as sr

app = FastAPI(title="Whisper Daemon", description="API for transcribing microphone input using Whisper")

mic = None

def get_mic_index_by_name(mic_name):
    """Find microphone index by name (partial match)"""
    microphone_names = sr.Microphone.list_microphone_names()

    for index, name in enumerate(microphone_names):
        if mic_name.lower() in name.lower():
            return index

    return None

@app.on_event("startup")
async def startup_event():
    global mic

    mic_name = os.getenv("MIC_NAME")
    pause_time = float(os.getenv("PAUSE_TIME", "1.5"))
    hallucinate_threshold = int(os.getenv("HALLUCINATE_THRESHOLD", "400"))
    mic_index = None

    if mic_name:
        mic_index = get_mic_index_by_name(mic_name)
        if mic_index is None:
            available_mics = sr.Microphone.list_microphone_names()
            print(f"ERROR: Microphone '{mic_name}' not found!")
            print("Available microphones:")
            for index, name in enumerate(available_mics):
                print(f"  Index: {index}, Name: {name}")
            sys.exit(1)
        print(f"Using microphone: {sr.Microphone.list_microphone_names()[mic_index]} (index: {mic_index})")
    else:
        print("Using default microphone (MIC_NAME env var not set)")

    print(f"Configuration: pause_time={pause_time}s, hallucinate_threshold={hallucinate_threshold}")

    mic = WhisperMic(
        mic_index=mic_index,
        pause=pause_time,
        hallucinate_threshold=hallucinate_threshold
    )

@app.get("/")
async def root():
    return {"message": "Whisper Daemon"}

@app.post("/transcribe-mic")
async def transcribe_mic():
    global mic
    if mic is None:
        return {"error": "WhisperMic not initialized"}

    result = mic.listen()
    return {"transcription": result}

if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", "8000"))
    uvicorn.run(app, host="0.0.0.0", port=port)
