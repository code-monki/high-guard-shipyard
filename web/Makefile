DEV_PORT   := 5173
PID_FILE   := .dev-server.pid

.PHONY: help dev stop preview build build-pages test typecheck install clean

# ── Default target ─────────────────────────────────────────────────────────
help:
	@echo ""
	@echo "High Guard Shipyard — Web"
	@echo ""
	@echo "  make dev           Start the Vite dev server in the background (port $(DEV_PORT))"
	@echo "  make stop          Stop the background dev server"
	@echo "  make preview       Build then serve the production bundle locally"
	@echo "  make build         Production build (type-checks first)"
	@echo "  make build-pages   Production build for GitHub Pages base path"
	@echo "  make test          Run the Vitest test suite"
	@echo "  make typecheck     Run vue-tsc type check without emitting files"
	@echo "  make install       Install npm dependencies"
	@echo "  make clean         Remove the dist/ build output"
	@echo ""

# ── Dev server ─────────────────────────────────────────────────────────────
dev:
	@if [ -f $(PID_FILE) ] && kill -0 $$(cat $(PID_FILE)) 2>/dev/null; then \
		echo "Dev server already running (PID $$(cat $(PID_FILE))) on http://localhost:$(DEV_PORT)"; \
	else \
		npm run dev -- --port $(DEV_PORT) & echo $$! > $(PID_FILE); \
		echo "Dev server started (PID $$(cat $(PID_FILE))) — http://localhost:$(DEV_PORT)"; \
	fi

stop:
	@if [ -f $(PID_FILE) ]; then \
		PID=$$(cat $(PID_FILE)); \
		if kill -0 $$PID 2>/dev/null; then \
			kill $$PID && echo "Dev server stopped (PID $$PID)"; \
		else \
			echo "No running process found for PID $$PID"; \
		fi; \
		rm -f $(PID_FILE); \
	else \
		echo "No PID file found — server may not be running"; \
	fi

# ── Build & preview ────────────────────────────────────────────────────────
build:
	npm run build

build-pages:
	npm run build:pages

preview: build
	npm run preview

# ── Quality ────────────────────────────────────────────────────────────────
test:
	npm run test

typecheck:
	npx vue-tsc --noEmit

# ── Housekeeping ───────────────────────────────────────────────────────────
install:
	npm install

clean:
	rm -rf dist
