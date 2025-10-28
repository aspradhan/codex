# Documentation Organization Notes

This document tracks documentation structure, potential consolidation opportunities, and maintenance notes.

## Current Structure (October 2025)

### Total Documentation
- **75 markdown files** across the repository
- Main README + specialized READMEs
- Comprehensive docs/ folder
- Archive and migration guides
- Third-party reference documentation

### Main Entry Points

1. **[README.md](../README.md)** - Main project overview (20KB)
   - Overview of entire Codex Mail platform
   - Quick start for all user types
   - Feature highlights and architecture

2. **[README_CODEX_MAIL.md](../README_CODEX_MAIL.md)** - MCP server focus (7KB)
   - Dedicated to MCP server component
   - Technical details of coordination system
   - MCP tool reference

3. **[DOCUMENTATION.md](../DOCUMENTATION.md)** - Master index (10KB)
   - Complete documentation catalog
   - Organized by topic and audience
   - Navigation guide

4. **[INTEGRATION_GUIDE.md](../INTEGRATION_GUIDE.md)** - Setup walkthrough (11KB)
   - Step-by-step integration
   - Configuration examples
   - Troubleshooting

## Documentation Categories

### User Documentation (Getting Started)
- README.md - Overview
- docs/getting-started.md - Detailed setup
- QUICKSTART_GUI.md - GUI quick start
- docs/CROSS_PLATFORM_GUI.md - Platform-specific GUI
- docs/authentication.md - Auth setup

### Agent Integration
- docs/AGENT_ONBOARDING.md - Complete onboarding (21KB)
- docs/CROSS_PROJECT_COORDINATION.md - Multi-repo patterns (15KB)
- INTEGRATION_GUIDE.md - Integration walkthrough

### Configuration & Features
- docs/config.md - Complete config reference (44KB)
- docs/THEME_CONFIG.md - Theme configuration
- docs/slash-commands.md - Command reference
- docs/exec.md - Execution system
- docs/sandbox.md - Sandbox modes

### Development
- DEVELOPING.md - Quick dev notes (3KB)
- docs/contributing.md - Contribution guide (5KB)
- AGENTS.md - Rust/codex-rs notes
- TEST_SUITE_RESET.md - Test suite docs (19KB)
- ROADMAP.md - Project roadmap

### Architecture & Design
- docs/project_idea_and_guide.md - Original design (37KB)
- INTEGRATION_SUMMARY.md - Integration architecture (11KB)
- docs/fork-enhancements.md - Fork-specific features
- docs/tui-chatwidget-refactor.md - TUI architecture
- docs/history_state_schema.md - State schema

## Potential Consolidation Opportunities

### Similar Documentation Pairs

1. **GUI Conversion Docs** (Similar size: 4KB each)
   - `docs/GUI_CONVERSION.md` - Detailed explanation
   - `docs/GUI_CONVERSION_SUMMARY.md` - Executive summary
   - **Recommendation**: Keep both - serve different audiences
     - GUI_CONVERSION.md: For developers understanding the approach
     - GUI_CONVERSION_SUMMARY.md: Quick reference for stakeholders

2. **Integration Docs** (Similar size: 11KB each)
   - `INTEGRATION_GUIDE.md` - User-facing setup guide
   - `INTEGRATION_SUMMARY.md` - Technical integration summary
   - **Recommendation**: Keep both - different purposes
     - INTEGRATION_GUIDE.md: Step-by-step user guide
     - INTEGRATION_SUMMARY.md: Technical documentation of integration work

3. **Development Docs** (Different sizes)
   - `DEVELOPING.md` - Quick dev notes (3KB)
   - `docs/contributing.md` - Full contribution guide (5KB)
   - **Recommendation**: Keep both - complementary
     - DEVELOPING.md: Quick reference for active developers
     - contributing.md: Full guidelines for new contributors

## Documentation Maintenance Guidelines

### When Adding New Documentation

1. **Check existing docs first** - Avoid duplication
2. **Update DOCUMENTATION.md** - Add to the master index
3. **Add cross-references** - Link related documents
4. **Choose appropriate location**:
   - Root level: User-facing, high-traffic documents
   - docs/: Technical documentation and guides
   - docs/dev/: Developer tooling and debugging
   - docs/plans/: Design proposals and planning
   - docs/migration/: Migration and upgrade guides
   - docs/archive/: Historical or deprecated docs

### Link Health

As of October 2025:
- ✅ All internal links in key documentation files verified
- ✅ No broken links detected in main entry points
- ✅ Cross-references properly maintained

### Archive Policy

Documents moved to `docs/archive/` when:
- Implementation is complete and stable
- Content is primarily historical
- Replaced by newer documentation
- Still useful for reference but not active development

Current archives:
- TUI migration guides (3 files)

## Structure Best Practices

### File Naming
- Use descriptive, kebab-case names
- Prefix with category when helpful (e.g., `GUI_`, `CROSS_`)
- All caps for root-level important docs (README, ROADMAP, etc.)

### Content Organization
- Start with clear title and overview
- Include table of contents for long documents
- Use consistent heading hierarchy
- Add "Last Updated" date for time-sensitive content
- Include links to related documentation

### Documentation Types

1. **Overview/README** - High-level introduction
2. **Guide** - Step-by-step instructions
3. **Reference** - Comprehensive technical details
4. **Tutorial** - Learning-focused walkthrough
5. **Design Doc** - Architecture and design decisions
6. **Migration** - Upgrade and transition guides
7. **Archive** - Historical reference

## Size Distribution

- Largest: third_party_docs/mcp_protocol_specs.md (308KB)
- Largest original: docs/config.md (44KB)
- Average: ~8KB per file
- Most root-level docs: 2-20KB (appropriate for overview)

## Future Considerations

### Potential Improvements

1. **Visual Documentation**
   - Add architecture diagrams
   - Include workflow diagrams
   - Expand screenshot collection

2. **Interactive Examples**
   - Add runnable code samples
   - Include configuration templates
   - Create example projects

3. **Video Guides**
   - Getting started screencast
   - Integration walkthrough
   - Feature demonstrations

4. **API Documentation**
   - Auto-generated from code
   - OpenAPI/Swagger for MCP server
   - Type definitions and schemas

### Monitoring

Review documentation quarterly for:
- Accuracy with latest code
- Broken links or outdated references
- Missing documentation for new features
- User feedback and common questions
- Consolidation opportunities

## Contact

For documentation questions or suggestions:
- Open an issue on GitHub
- Submit a pull request with improvements
- Discuss in GitHub Discussions

---

**Last Updated**: October 2025
**Next Review**: January 2026
