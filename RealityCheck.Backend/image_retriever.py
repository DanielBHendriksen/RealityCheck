from pathlib import Path
import shutil

def retrieve_images(query: str, job_id: str) -> Path:
    # Simulate image search by copying demo images into a job folder
    demo_folder = Path("demo_images")
    job_folder = Path(f"jobs/{job_id}/images")
    job_folder.mkdir(parents=True, exist_ok=True)

    for img in demo_folder.glob("*.jpg"):
        shutil.copy(img, job_folder / img.name)

    return job_folder
