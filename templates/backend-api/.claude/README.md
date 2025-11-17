# Claude Code Configuration - Node.js Backend API Template

This directory contains specialized Claude Code configuration for Node.js backend API development.

## Specialized Agents

- **test-engineer**: Testing specialist for unit, integration, and API tests
- **codebase-analyzer**: Analyzes codebase implementation details

## Slash Commands

- `/implement_plan`: Implement technical plans with verification
- `/test-coverage`: Analyze test coverage and suggest missing tests
- `/create_plan`: Create detailed implementation plans with research
- `/validate_plan`: Validate implementation against plan, verify success criteria
- `/research_codebase`: Research codebase to deeply understand implementation before making changes

## Usage

These configurations are automatically loaded when Claude Code runs in this project directory. The specialized agents and commands are optimized for backend API development workflows with Node.js, TypeScript, and Express.

## Backend API Development Tips

- Always validate and sanitize user input
- Implement proper error handling middleware
- Use OpenAPI/Swagger for API documentation
- Write integration tests for API endpoints
- Implement rate limiting and security headers
- Use TypeScript strict mode
- Keep business logic separate from route handlers
- Use Prisma migrations for database schema changes
- Implement proper logging for debugging and monitoring
