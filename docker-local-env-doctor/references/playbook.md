# Playbook

## Purpose

Before Claude codes, checks whether the local app can run: Docker containers, ports, env files, package install, DB seed, API health.

Category mission:

Apply specialized product and operations knowledge for AI contribution tracking, PR learning, payment/OTP/QR flows, async events, real-time state, Docker, GHCR, Lightsail, Nginx, and incident workflows.

## Procedure

1. Identify domain risk first. 2. Gather source, runtime, and operational evidence. 3. Map UI state to backend or deployment state. 4. Enforce high-risk review gates. 5. Produce audit-ready evidence. 6. Feed lessons back into future skill guidance.

## Skill-Specific Moves

- Primary purpose: Before Claude codes, checks whether the local app can run: Docker containers, ports, env files, package install, DB seed, API health.
- Check local/prod parity, ports, health checks, image tags, reverse proxy rules, and rollback path.

## Decision Rules

Treat payment, OTP, QR credential, deployment, and incident-remediation changes as high-risk unless proven otherwise. Prefer observability and rollback evidence over optimistic claims.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
