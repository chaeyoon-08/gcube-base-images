# gcube-base-images

gcube GPU 플랫폼용 베이스 이미지 모음입니다. 공식 이미지(`pytorch/pytorch`, `nvidia/cuda`, NGC TensorFlow)에 gcube 공통 설정만 얹은 것으로, 그 위에 실습 환경을 쌓는 토대로 사용합니다.

## 계열

### PyTorch — `gcube-pytorch-<torch>-cuda<cuda>`

공식 `pytorch/pytorch` 이미지 기반. PyTorch·CUDA·cuDNN·Python이 포함됩니다.

| PyTorch \ CUDA | 12.6 | 12.8 | 13.0 |
|---|:---:|:---:|:---:|
| 2.8 | O | O | — |
| 2.9 | O | O | O |
| 2.10 | O | O | O |
| 2.11 | O | O | O |

각 이미지마다 `:runtime` / `:devel` 두 태그 제공 (11이미지 × 2 = 22개)

### Ubuntu+CUDA — `gcube-ubuntu<ubuntu>-cuda<cuda>`

공식 `nvidia/cuda` 이미지 기반. CUDA만 포함하며 프레임워크는 없는 깡통 환경입니다.

| Ubuntu \ CUDA | 12.6 | 12.8 | 13.0 |
|---|:---:|:---:|:---:|
| 22.04 | O | O | O |
| 24.04 | O | O | O |

각 이미지마다 `:runtime` / `:devel` 두 태그 제공 (6이미지 × 2 = 12개)

### TensorFlow — `gcube-tensorflow-<tf>-cuda<cuda>`

공식 TensorFlow가 Blackwell(sm_120)을 미지원하여 NGC(`nvcr.io/nvidia/tensorflow:25.02-tf2-py3`)에서 추출한 이미지입니다.

| TensorFlow | CUDA | 태그 |
|---|---|---|
| 2.17 | 12.8 | `:runtime` |

## 공통 설정

모든 이미지에 포함된 공통 구성입니다.

- 시스템 유틸: `git`, `curl`, `wget`, `vim`, `tmux`, `htop`
- 작업 디렉터리: `/workspace`
- 캐시 경로: `HF_HOME=/workspace/.cache/huggingface`, `PIP_CACHE_DIR=/workspace/.cache/pip`
- git 자동 설정 (환경변수로 제어, 전부 선택)

| 환경변수 | 설명 |
|---|---|
| `GIT_USER_NAME` | 커밋 작성자 이름 |
| `GIT_USER_EMAIL` | 커밋 작성자 이메일 |
| `GIT_TOKEN` | PAT. private repo 인증용 |
| `GIT_HOST` | git 호스트 (기본값 `github.com`) |
| `GIT_CLONE_REPO` | 워크로드 시작 시 `/workspace`에 자동 clone할 저장소 URL |

## 이미지 주소

```
# GitHub Container Registry
ghcr.io/<owner>/<이미지명>:<태그>

# Docker Hub
<owner>/<이미지명>:<태그>
```

두 레지스트리에 동일한 이미지가 제공됩니다.