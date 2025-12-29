# OhMyOpenCode Agent Usage Guide

This guide explains how to effectively use and manage your specialized AI agents. You can call any agent explicitly using the `@agent-name` syntax in your prompts.

## 🛠️ Core Orchestration

### **Sisyphus**
- **Role**: Project Lead & Orchestrator
- **When to use**: Your default starting point. Handles complex, multi-step tasks by delegating to specialized subagents.
- **Model**: GitHub Copilot Gemini 3 Flash

### **Planner-Sisyphus**
- **Role**: Strategic Planning
- **When to use**: When you need a high-level architectural plan or a detailed roadmap before starting implementation.
- **Trigger**: Automatically replaces or complements the default OpenCode 'plan' agent.

### **Builder-Sisyphus**
- **Role**: Implementation Specialist
- **When to use**: For direct code generation and applying changes based on a plan.
- **Trigger**: Automatically replaces or complements the default OpenCode 'build' agent.

---

## 👥 Specialized Teammates

### **@oracle**
- **Role**: Senior Architect & Strategic Advisor
- **When to use**: 
  - Designing complex systems or multi-module integrations.
  - Hard debugging after several failed attempts.
  - Reviewing code for security or performance bottlenecks.
- **Example**: `@oracle Review this database schema and propose an indexing strategy.`

### **@librarian**
- **Role**: Knowledge Researcher
- **When to use**: 
  - Looking up official documentation for unfamiliar libraries.
  - Finding real-world implementation examples in public GitHub repositories.
  - Deep analysis of multi-repository dependencies.
- **Example**: `@librarian Find examples of how people use the latest React Server Components with Next.js.`

### **@explore**
- **Role**: Codebase Scout
- **When to use**: 
  - Finding specific logic, patterns, or file locations in a large codebase.
  - Quick traversals to understand how different layers interact.
- **Example**: `@explore Find where the authentication middleware is applied across the API routes.`

### **@frontend-ui-ux-engineer**
- **Role**: Creative UI Developer
- **When to use**: 
  - Styling components (Tailwind, CSS-in-JS, etc.).
  - Layout adjustments and responsive design.
  - Creating beautiful, interactive UI components from scratch.
- **Example**: `@frontend Refactor this UserProfile component to be responsive and use a modern card layout.`

### **@document-writer**
- **Role**: Technical Writer
- **When to use**: 
  - Writing README files, API documentation, or user guides.
  - Translating code logic into clear human-readable prose.
- **Example**: `@document-writer Generate a comprehensive README for this new microservice.`

### **@multimodal-looker**
- **Role**: Visual Content Analyst
- **When to use**: 
  - Analyzing UI mocks, screenshots, or architectural diagrams (PDF/Image).
  - Extracting information from non-text documents.
- **Example**: `@multimodal-looker [attach image] Explain the data flow shown in this diagram.`

---

## ⚙️ How to Manage Agents

- **Enable/Disable**: Edit `~/.config/opencode/oh-my-opencode.json` and modify the `disabled_agents` array.
- **Change Models**: Override models for specific agents in the `agents` object of your configuration.
- **Parallel Work**: Sisyphus can run these agents in the background. Use `background_task` for maximum throughput.

oMoMoMo... Happy Coding!
