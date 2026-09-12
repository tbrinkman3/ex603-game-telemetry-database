# Soccar Alliance

A relational database platform for capturing player activity, match history, and game-mode metadata for Soccar Alliance, a vehicle-soccer video game.

## Domain

## Schema
```mermaid
erDiagram
    PLAYERS ||--o{ MATCH_PARTICIPANTS : "participates in"
    MATCHES ||--o{ MATCH_PARTICIPANTS : "records"
    GAME_MODES ||--o{ MATCH_MODES : "tags"
    MATCHES ||--|{ MATCH_MODES : "grouped with"

    PLAYERS {
        uuid player_id PK
        string player_name
    }
    MATCHES {
        uuid match_id PK
        string match_name
        bool is_active
        int max_players
    }
    MATCH_PARTICIPANTS {
        uuid player_id PK,FK
        uuid match_id PK,FK
        time entered_at
        time left_at
        int player_score
    }
    GAME_MODES {
        uuid game_id PK
        string game_name
    }
    MATCH_MODES {
        uuid match_id PK,FK
        uuid game_id PK,FK
    }
```

## Query Catalogue

## Technical Highlights

## What I Would Do Differently

## Video Presentation

## How to Run It
