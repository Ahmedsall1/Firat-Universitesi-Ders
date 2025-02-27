from fastapi import FastAPI, File, UploadFile, Form
from typing import List, Dict
from pydantic import BaseModel
import uuid

# Create a FastAPI instance
app = FastAPI()

# Define a model for image metadata
class ImageMetadata(BaseModel):
    id: str
    category: str

@app.post("/upload-images/")
async def upload_images(
    files: List[UploadFile] = File(...),
    metadata: List[str] = Form(...),  # Metadata as a list of JSON strings
):
    """
    Accepts images and metadata from the client.
    """
    # Parse the metadata
    parsed_metadata = []
    for meta in metadata:
        parsed_metadata.append(ImageMetadata.parse_raw(meta))

    # Logic to process images and return filtered IDs
    category_map = {}
    for meta in parsed_metadata:
        category_map.setdefault(meta.category, []).append(meta.id)

    # Select N IDs per category (for this example, 1 for shoes, 2 for sweaters, etc.)
    result = {}
    for category, ids in category_map.items():
        # Dummy logic: Select the first N IDs per category
        num_to_select = {"shoes": 1, "sweater": 2, "pantalon": 3}.get(category, 1)
        result[category] = ids[:num_to_select]

    return {"selected_ids": result}
