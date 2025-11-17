#!/bin/bash

# Claude Templates Setup Script
# This script initializes a project with shared Claude configuration

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATES_ROOT="$(dirname "$SCRIPT_DIR")"
SHARED_DIR="$TEMPLATES_ROOT/.shared"

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Claude Templates Setup Script           ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo ""

# Function to display usage
usage() {
    echo "Usage: $0 [PROJECT_PATH] [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --template TEMPLATE    Use a specific template (music-app, react-pwa, firebase-app, backend-api)"
    echo "  --shared-only          Only link to shared configs (no template-specific files)"
    echo "  --help                 Display this help message"
    echo ""
    echo "Examples:"
    echo "  $0 ~/projects/my-app"
    echo "  $0 ~/projects/my-app --template react-pwa"
    echo "  $0 ~/projects/my-app --shared-only"
    exit 1
}

# Parse arguments
PROJECT_PATH=""
TEMPLATE=""
SHARED_ONLY=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --template)
            TEMPLATE="$2"
            shift 2
            ;;
        --shared-only)
            SHARED_ONLY=true
            shift
            ;;
        --help)
            usage
            ;;
        *)
            if [ -z "$PROJECT_PATH" ]; then
                PROJECT_PATH="$1"
            else
                echo -e "${RED}Error: Unknown argument: $1${NC}"
                usage
            fi
            shift
            ;;
    esac
done

# Check if project path is provided
if [ -z "$PROJECT_PATH" ]; then
    echo -e "${RED}Error: Project path is required${NC}"
    usage
fi

# Convert to absolute path
PROJECT_PATH="$(cd "$(dirname "$PROJECT_PATH")" 2>/dev/null && pwd)/$(basename "$PROJECT_PATH")" || PROJECT_PATH="$PROJECT_PATH"

# Check if project directory exists
if [ ! -d "$PROJECT_PATH" ]; then
    echo -e "${YELLOW}Warning: Project directory does not exist: $PROJECT_PATH${NC}"
    read -p "Create it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "$PROJECT_PATH"
        echo -e "${GREEN}✓ Created project directory${NC}"
    else
        echo -e "${RED}Aborted.${NC}"
        exit 1
    fi
fi

# Create .claude directory if it doesn't exist
CLAUDE_DIR="$PROJECT_PATH/.claude"
if [ ! -d "$CLAUDE_DIR" ]; then
    mkdir -p "$CLAUDE_DIR"
    echo -e "${GREEN}✓ Created .claude directory${NC}"
else
    echo -e "${YELLOW}! .claude directory already exists${NC}"
    read -p "Continue? This will replace existing symlinks. (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Aborted.${NC}"
        exit 1
    fi
fi

cd "$CLAUDE_DIR"

# Remove existing symlinks if they exist
[ -L "agents" ] && rm agents
[ -L "commands" ] && rm commands
[ -L "skills" ] && rm skills

# Create symlinks to shared configuration
echo -e "${BLUE}Creating symlinks to shared configuration...${NC}"
ln -s "$SHARED_DIR/agents" agents
ln -s "$SHARED_DIR/commands" commands
ln -s "$SHARED_DIR/skills" skills
echo -e "${GREEN}✓ Linked to shared agents, commands, and skills${NC}"

# If not shared-only, copy template-specific files
if [ "$SHARED_ONLY" = false ] && [ -n "$TEMPLATE" ]; then
    TEMPLATE_DIR="$TEMPLATES_ROOT/templates/$TEMPLATE/.claude"

    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo -e "${RED}Error: Template not found: $TEMPLATE${NC}"
        echo -e "${YELLOW}Available templates: music-app, react-pwa, firebase-app, backend-api${NC}"
        exit 1
    fi

    echo -e "${BLUE}Copying template-specific files from $TEMPLATE...${NC}"

    # Copy specialized agents/commands/skills if they exist
    if [ -d "$TEMPLATE_DIR/specialized" ]; then
        cp -r "$TEMPLATE_DIR/specialized" .
        echo -e "${GREEN}✓ Copied specialized configurations${NC}"
    fi

    # Copy template-specific documentation
    [ -f "$TEMPLATE_DIR/README.md" ] && cp "$TEMPLATE_DIR/README.md" . && echo -e "${GREEN}✓ Copied README.md${NC}"
    [ -f "$TEMPLATE_DIR/QUICK-REFERENCE.md" ] && cp "$TEMPLATE_DIR/QUICK-REFERENCE.md" . && echo -e "${GREEN}✓ Copied QUICK-REFERENCE.md${NC}"
    [ -f "$TEMPLATE_DIR/SECRETS-SETUP.md" ] && cp "$TEMPLATE_DIR/SECRETS-SETUP.md" . && echo -e "${GREEN}✓ Copied SECRETS-SETUP.md${NC}"

    # Copy settings example
    if [ -f "$TEMPLATE_DIR/settings.local.json.example" ]; then
        cp "$TEMPLATE_DIR/settings.local.json.example" .
        echo -e "${GREEN}✓ Copied settings.local.json.example${NC}"
        echo -e "${YELLOW}! Don't forget to copy settings.local.json.example to settings.local.json and configure it${NC}"
    fi
fi

# Create a basic instructions.md if it doesn't exist
if [ ! -f "instructions.md" ]; then
    cat > instructions.md << 'EOF'
# Claude Instructions for This Project

## Project Overview

[Describe your project here]

## Quick Reference

- **Architecture docs** → `docs/ARCHITECTURE.md`
- **Common tasks** → Use slash commands (e.g., /create_plan, /implement_plan)

## Project-Specific Guidelines

### 1. [Your Domain]
- [Add your specific guidelines]

### 2. File Management
- [Document your file structure]

### 3. Common Pitfalls to Avoid

1. **[Pitfall]**
   - [Description and solution]

## Before Starting Work

1. Review project documentation
2. Check current status
3. Understand recent changes
EOF
    echo -e "${GREEN}✓ Created instructions.md template${NC}"
fi

# Create a basic settings.local.json if it doesn't exist and no template was used
if [ ! -f "settings.local.json" ] && [ "$SHARED_ONLY" = true ] || [ -z "$TEMPLATE" ]; then
    cat > settings.local.json << 'EOF'
{
  "permissions": {
    "allow": [
      "Bash(python3:*)",
      "Bash(npm:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)"
    ],
    "deny": [],
    "ask": []
  }
}
EOF
    echo -e "${GREEN}✓ Created settings.local.json template${NC}"
    echo -e "${YELLOW}! Review and customize settings.local.json for your project's needs${NC}"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Setup Complete! ✓                       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Project Configuration:${NC}"
echo -e "  Location: $PROJECT_PATH"
echo -e "  Shared agents: ${GREEN}✓${NC} (5 universal agents)"
echo -e "  Shared commands: ${GREEN}✓${NC} (7 universal commands)"
echo -e "  Shared skills: ${GREEN}✓${NC}"
if [ -n "$TEMPLATE" ]; then
    echo -e "  Template: ${GREEN}$TEMPLATE${NC}"
fi
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo -e "  1. Edit ${BLUE}.claude/instructions.md${NC} with project-specific context"
echo -e "  2. Review ${BLUE}.claude/settings.local.json${NC} permissions"
echo -e "  3. Start using Claude Code in your project!"
echo ""
echo -e "${BLUE}Available Slash Commands:${NC}"
echo -e "  /commit              - Create git commits"
echo -e "  /create_plan         - Create implementation plans"
echo -e "  /implement_plan      - Implement technical plans"
echo -e "  /validate_plan       - Validate implementations"
echo -e "  /create_handoff      - Create handoff documents"
echo -e "  /resume_handoff      - Resume from handoff"
echo -e "  /research_codebase   - Document codebase"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"
