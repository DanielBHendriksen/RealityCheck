from pathlib import Path
import shutil

def run_photogrammetry(image_dir: Path, job_id: str) -> Path:
    """
    Simulates generating a .usdz model from images.
    For now, just copies a dummy.usdz file into the static/usdz folder.
    """
    dummy_source = Path("demo_models/dummy.usdz")
    output_path = Path(f"static/usdz/{job_id}.usdz")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy(dummy_source, output_path)

    return output_path
