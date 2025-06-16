from fastapi import FastAPI
from fastapi.responses import FileResponse
from pydantic import BaseModel
from uuid import uuid4
from pathlib import Path

from image_retriever import retrieve_images
from photogrammetry import run_photogrammetry

app = FastAPI()

# Where generated .usdz models will be stored
USDZ_OUTPUT_DIR = Path("static/usdz")
USDZ_OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Define the expected JSON format
class ProductRequest(BaseModel):
    product_name: str

@app.post("/generate_model")
async def generate_model(request: ProductRequest):
    job_id = str(uuid4())
    query = request.product_name

    # 1. Retrieve images (mocked for now)
    image_dir = retrieve_images(query, job_id)

    # 2. Run photogrammetry (mocked for now)
    usdz_path = run_photogrammetry(image_dir, job_id)

    # 3. Return the model link
    return {"model_url": f"/model/{usdz_path.name}"}

@app.get("/model/{model_name}")
async def get_model(model_name: str):
    path = USDZ_OUTPUT_DIR / model_name
    if path.exists():
        return FileResponse(path)
    return {"error": "Model not found"}, 404