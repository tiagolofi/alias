#!/usr/bin/env bash

organize_folder() {
    read -p "Diretório raiz: " dir
    cd "$dir" || exit 1
    whereiam=$(pwd)
    echo "Local atual: $whereiam"
}

clone_repo() {
    read -p "Link para o repositório do github: " repo
    git clone "$repo"

    repo_name=$(basename "$repo" .git)

    cd "$repo_name"
}

config_python() {
    python3 -m venv env
    source env/bin/activate
    touch .env
    mkdir tests
    pip install setuptools python-dotenv
    pip freeze > "requirements.txt"
}

build_script() {
    build_script="python -m pip install --upgrade pip
python -m pip install --upgrade build
python -m build"

    echo "$build_script" > build.sh

    chmod +x build.sh
}

setup_script() {
    setup_script='''from setuptools import setup, find_packages

setup(
    name="simple-mongo",
    version="0.0.1",
    description="Wrapper do PyMongo para aplicações básicas",
    author="tiagolofi",
    author_email="tiagolofi@example.com",
    url="https://github.com/tiagolofi/simple-mongo",
    packages=find_packages(),
    python_requires=">=3.9",
    install_requires=[
        "pymongo", "python-dotenv"
    ],
    extras_require={
    },
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
    ],
)'''

    echo "$setup_script" > setup.py
}

echo "### ALIAS DE CONFIGURAÇÃO DE PROJETOS PYTHON - LIBS ###"
echo "[INFO] Configurando diretórios..."
organize_folder
echo "[INFO] Preparando repositório github..."
clone_repo
echo "[INFO] Preparando ambiente virtual do Python..."
config_python
echo "[INFO] Preparando scripts auxiliares..."
build_script
setup_script
echo "[INFO] Ambiente construído com sucesso!"