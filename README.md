# gcube-base-images

gcube GPU 플랫폼용 기본 이미지 모음입니다. PyTorch·TensorFlow·CUDA 등 공식 환경에 gcube 공통 설정만 얹어, 실습 환경의 출발점으로 사용합니다.

## 이미지 라인업

### PyTorch — `gcube-pytorch-<torch>-cuda<cuda>`

PyTorch·CUDA·cuDNN·Python이 포함되어 있습니다.

| PyTorch \ CUDA | 12.6 | 12.8 | 13.0 |
|---|:---:|:---:|:---:|
| 2.8 | O | O | — |
| 2.9 | O | O | O |
| 2.10 | O | O | O |
| 2.11 | O | O | O |

각 이미지마다 `:runtime` / `:devel` 두 태그 제공.

### Ubuntu+CUDA — `gcube-ubuntu<ubuntu>-cuda<cuda>`

CUDA만 포함되어 있어, 사용자가 원하는 프레임워크를 직접 설치하는 환경입니다.

| Ubuntu \ CUDA | 12.6 | 12.8 | 13.0 |
|---|:---:|:---:|:---:|
| 22.04 | O | O | O |
| 24.04 | O | O | O |

각 이미지마다 `:runtime` / `:devel` 두 태그 제공.

### TensorFlow — `gcube-tensorflow-<tf>-cuda<cuda>`

TensorFlow·CUDA·cuDNN·Python이 포함되어 있습니다.

| TensorFlow | CUDA | 태그 |
|---|---|---|
| 2.17 | 12.8 | `:runtime` |

## 사용

gcube 워크로드에서 직접 사용하거나, 자체 Docker 이미지를 빌드할 때 `FROM`으로 사용합니다.

AWS ECR이 GitHub Container Registry보다 다운로드 속도가 빠르기 때문에 사용을 권장합니다. 단, 현재 AWS ECR에는 아래 3개만 제공되며, 그 외 이미지는 GitHub Container Registry에서 받을 수 있습니다.

```
# AWS ECR (권장, 현재 3종)
public.ecr.aws/g3x5o1w3/gcube/base/pytorch-2.11-cuda13.0:runtime
public.ecr.aws/g3x5o1w3/gcube/base/ubuntu24.04-cuda13.0:runtime
public.ecr.aws/g3x5o1w3/gcube/base/tensorflow-2.17-cuda12.8:runtime

# GitHub Container Registry (전체)
ghcr.io/data-alliance/gcube-pytorch-2.11-cuda13.0:runtime
ghcr.io/data-alliance/gcube-ubuntu24.04-cuda13.0:runtime
ghcr.io/data-alliance/gcube-tensorflow-2.17-cuda12.8:runtime
```

## 공통 설정

- 시스템 유틸: `git`, `curl`, `wget`, `vim`, `tmux`, `htop`
- 작업 디렉터리: `/workspace`
- 캐시 경로: `HF_HOME=/workspace/.cache/huggingface`, `PIP_CACHE_DIR=/workspace/.cache/pip`

## 환경변수

모든 환경변수는 선택 사항입니다. 비공개 저장소를 사용하거나 커밋 작성자를 지정하려는 경우에만 입력합니다.

| 변수 | 기본값 | 설명 |
|---|---|---|
| `GIT_CLONE_REPO` | (없음) | 워크로드 시작 시 `/workspace`에 자동 clone할 저장소 URL |
| `GIT_USER_NAME` | (없음) | git 커밋 작성자 이름 |
| `GIT_USER_EMAIL` | (없음) | git 커밋 작성자 이메일 |
| `GIT_TOKEN` | (없음) | git 인증 토큰(PAT). private 저장소 clone/push 시 필요 |
| `GIT_HOST` | `github.com` | git 호스트. GitLab(`gitlab.com`) 또는 사내 git 서버 주소도 가능 |