help:
	@echo "Available commands:"
	@echo "  bootstrap"

bootstrap:
	@carthage bootstrap --use-ssh
