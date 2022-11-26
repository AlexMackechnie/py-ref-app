.PHONY: install-build-tools freeze freeze-upgrade freeze-dev freeze-dev-upgrade build

# ------------------------------- #
# Build Environment               #
# ------------------------------- #

# Installing Build Tools

install-build-tools:
	python -m pip install --upgrade build wheel pip-tools

# Freezing Dependencies

freeze: install-build-tools
	python -m piptools compile -o requirements.txt pyproject.toml

freeze-upgrade: install-build-tools
	python -m piptools compile -o requirements.txt --upgrade pyproject.toml

freeze-dev: install-build-tools
	python -m piptools compile --extra dev -o requirements-dev.txt pyproject.toml

freeze-dev-upgrade: install-build-tools
	python -m piptools compile --extra dev -o requirements-dev.txt --upgrade pyproject.toml

# ------------------------------- #
# Dev Execution Environment       #
# ------------------------------- #

# Run App in Development Environment

install-dev: requirements.txt requirements-dev.txt pyproject.toml
	python -m pip install -r requirements.txt --compile
	python -m pip install -r requirements-dev.txt --compile
	python -m pip install -e . --no-deps

run: requirements.txt
	python -m ref_app.app

