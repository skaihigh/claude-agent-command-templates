# Claude Code Configuration - Firebase Full-Stack App Template

This directory contains specialized Claude Code configuration for Firebase full-stack application development.

## Specialized Agents

- **react-architect**: Senior React + TypeScript architect specializing in component design, state management, and performance optimization
- **test-engineer**: Testing specialist for unit, integration, E2E tests
- **codebase-analyzer**: Analyzes codebase implementation details

## Slash Commands

- `/implement_plan`: Implement technical plans with verification
- `/test-coverage`: Analyze test coverage and suggest missing tests
- `/create_plan`: Create detailed implementation plans with research
- `/validate_plan`: Validate implementation against plan, verify success criteria
- `/new-component`: Create a new React component with TypeScript and tests
- `/research_codebase`: Research codebase to deeply understand implementation before making changes

## Usage

These configurations are automatically loaded when Claude Code runs in this project directory. The specialized agents and commands are optimized for Firebase full-stack development workflows with React frontend and Firebase backend (Auth, Firestore, Storage, Functions).

## Firebase-Specific Tips

- Use the Firebase MCP for deployment and management tasks
- Test with Firebase Emulator Suite before deploying
- Keep security rules in sync with your data model
- Use TypeScript for both frontend and Cloud Functions
- Implement proper error handling for Firebase operations
