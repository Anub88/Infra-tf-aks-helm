from typing import Any, Dict, List
from uuid import UUID, uuid4
from copy import deepcopy
from pydantic import BaseModel, Field


class InferenceQueryDto(BaseModel):
    TenantId: str
    ExamId: str


class InferenceQueryResultDto(BaseModel):
    NumEntities: int
    # Holds result data from TableStorage/Cosmos/etc.
    Data: Any


class InferenceDocumentDto(BaseModel):
    id: UUID = Field(default_factory=uuid4)
    content: Dict

    def get_inference_results_with_id(self):
        content_with_id = deepcopy(self.content)
        content_with_id["id"] = str(self.id)
        return content_with_id


class InferenceResultsDto(BaseModel):
    tenant: str
    json_documents: List[InferenceDocumentDto] = []
