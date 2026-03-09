import torch
import torch_geometric
import transformers
import accelerate

def verify():
    print(f"PyTorch Version: {torch.__version__}")
    print(f"CUDA Available: {torch.cuda.is_available()}")
    if torch.cuda.is_available():
        print(f"CUDA Version (Runtime): {torch.version.cuda}")
        print(f"GPU Device: {torch.cuda.get_device_name(0)}")
        
        # Test bfloat16 support (Common for Llama-2 training)
        try:
            x = torch.randn(1, 10).to(device='cuda', dtype=torch.bfloat16)
            print("BFloat16 support: OK")
        except Exception as e:
            print(f"BFloat16 support: FAILED ({e})")

    print(f"Torch Geometric Version: {torch_geometric.__version__}")
    print(f"Transformers Version: {transformers.__version__}")
    print(f"Accelerate Version: {accelerate.__version__}")

    # Check if PyG components are linked correctly
    try:
        from torch_scatter import scatter
        from torch_sparse import SparseTensor
        print("PyG (Scatter/Sparse) components: OK")
    except ImportError as e:
        print(f"PyG components: MISSING ({e})")

if __name__ == "__main__":
    verify()
