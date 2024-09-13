.PHONY: docs local

local:
	uv run honcho start -f Procfile.dev

build:
	docker compose build

shell:
	docker compose run --run web bash

deploy:
	git push heroku main

graph:
	uv run manage.py graph_models \
		--rankdir BT \
		accounts \
		core \
		courses \
		notifications \
		referrals \
		reports \
		schools \
		students \
		teachers \
		users \
		-o models.png

# For the next time I think about making this faster:
# -n auto --dist loadfile, 8 CPUs, 445 tests, 1m15s
# -n 4    --dist loadfile, 4 CPUs, 445 tests, 43s
# -n 2    --dist loadfile, 4 CPUs, 445 tests, 39s
# no parallelism,                  445 tests, 41s
coverage:
	uv run pytest --cov=homeschool --migrations -n 2 --dist loadfile

test: fcov

# fcof == "fast coverage" by skipping migrations checking. Save that for CI.
# -n 8 --dist loadfile, 8 CPUs, 515 tests, 20s
# -n 4 --dist loadfile, 4 CPUs, 515 tests, 13s
# -n 2 --dist loadfile, 4 CPUs, 515 tests, 15s
fcov:
	@echo "Running fast coverage check"
	@uv run pytest --cov=homeschool -n 4 --dist loadfile -q

mypy:
	uv run mypy homeschool project manage.py

docs:
	uv run make -C docs html

servedocs:
	cd docs/_build/html && python3 -m http.server

pip:
	pip-compile --output-file requirements.txt requirements.in
