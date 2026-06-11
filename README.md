# gcube-base-images

gcube GPU 플랫폼용 베이스 이미지. 공식 이미지에 공통 설정(git 구성, 작업 디렉터리, 캐시 경로)을 더한 토대 이미지로, 상위 응용 이미지가 이를 기반으로 빌드됩니다.

## 이미지 계열

| 계열 | 이미지 | 기반 | 구성 |
|---|---|---|---|
| Ubuntu | `gcube-ubuntu<ubuntu>-cuda<cuda>` | `nvidia/cuda` | CUDA, Python |
| PyTorch | `gcube-pytorch-<torch>-cuda<cuda>` | `pytorch/pytorch` | PyTorch, CUDA, cuDNN, Python |
| TensorFlow | `gcube-tensorflow-<tf>-cuda<cuda>` | `gcube-ubuntu` | TensorFlow (NGC), CUDA, Python |

```
ghcr.io/<owner>/gcube-ubuntu24.04-cuda12.8:runtime
ghcr.io/<owner>/gcube-pytorch-2.11-cuda12.8:runtime
ghcr.io/<owner>/gcube-tensorflow-2.17-cuda12.8:runtime
```

## 라인업

### Ubuntu
CUDA(12.6 / 12.8 / 13.0) × Ubuntu(22.04 / 24.04) × (runtime / devel), 총 12개.
프레임워크가 포함되지 않은 토대 이미지입니다.

### PyTorch
PyTorch(2.8 / 2.9 / 2.10 / 2.11) × CUDA(12.6 / 12.8 / 13.0) × (runtime / devel), 총 22개.
(PyTorch 2.8 + CUDA 13.0 조합은 제공되지 않습니다.)

### TensorFlow
`gcube-tensorflow-2.17-cuda12.8:runtime` (NGC 25.02 기반), 1개.
RTX 50 시리즈(Blackwell, sm_120) 지원을 위해 NVIDIA NGC 컨테이너의 TensorFlow 런타임을 사용합니다.

## 공통 구성

- 시스템 유틸리티: `git`, `curl`, `wget`, `vim`, `tmux`, `htop`, `ca-certificates`
- 작업 디렉터리: `/workspace`
- 캐시 경로: `HF_HOME`, `PIP_CACHE_DIR`
- entrypoint: 환경변수 기반 git 구성 및 작업 저장소 자동 clone

## 환경변수

모든 환경변수는 선택 사항이며, 미지정 시 해당 단계를 건너뜁니다.

| 변수 | 기본값 | 설명 |
|---|---|---|
| `GIT_USER_NAME` | — | 커밋 작성자 이름 |
| `GIT_USER_EMAIL` | — | 커밋 작성자 이메일 |
| `GIT_TOKEN` | — | 개인 액세스 토큰 (비공개 저장소 인증) |
| `GIT_HOST` | `github.com` | git 호스트 |
| `GIT_CLONE_REPO` | — | 컨테이너 시작 시 `/workspace`에 자동 clone할 저장소 URL |

`GIT_TOKEN`은 최소 권한과 짧은 만료 기간을 가진 전용 토큰 사용을 권장합니다.

## 빌드

GitHub Actions의 수동 실행(workflow_dispatch)으로 빌드하며, 계열·버전을 선택할 수 있습니다. ghcr.io와 Docker Hub에 동시 푸시됩니다.

TensorFlow 계열은 `gcube-ubuntu24.04-cuda12.8:runtime`을 기반으로 하므로, 해당 Ubuntu 이미지를 먼저 빌드해야 합니다.

사전 설정:
- 저장소 Settings → Actions → Workflow permissions: "Read and write"
- Secrets: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`

## 구성 파일

```
gcube-base-images/
├─ Dockerfile.ubuntu
├─ Dockerfile.pytorch
├─ Dockerfile.tensorflow
├─ entrypoint.sh
├─ README.md
└─ .github/workflows/build.yml
```