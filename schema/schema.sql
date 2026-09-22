-- =================================================================
-- EX 603 Assignment 2 — schema.sql
-- Theme: Game Telemetry
-- Author: Tyler Brinkman
-- Target: PostgreSQL 14+
-- =================================================================
-- Reset. Reverse creation order, so no dependency blocks a drop.
DROP TABLE IF EXISTS match_participants    CASCADE;
DROP TABLE IF EXISTS match_modes   CASCADE;
DROP TABLE IF EXISTS matches   CASCADE;
DROP TABLE IF EXISTS game_modes   CASCADE;
DROP TABLE IF EXISTS players    CASCADE;

-- 1. Players have no external reference, they are standalone.
CREATE TABLE players(
  player_id UUID PRIMARY KEY,
  player_name VARCHAR(16) UNIQUE NOT NULL,
  CONSTRAINT chk_player_name_no_whitespace CHECK (length(trim(player_name)) > 0)
);

-- 2. Same as players, no external reference, they are standalone.

CREATE TABLE game_modes(
  game_id UUID PRIMARY KEY,
  game_name VARCHAR(20) NOT NULL
);

-- 3. Same as players, no external reference, they are standalone.

CREATE TABLE matches(
  match_id UUID PRIMARY KEY,
  match_name VARCHAR(30) NOT NULL,
  is_active BOOLEAN NOT NULL,
  max_players INTEGER NOT NULL,
  CONSTRAINT chk_max_players_positive CHECK (max_players > 0)
);

-- 4. Requires match_id and game_id to exist before creation.

CREATE TABLE match_modes(
  game_id UUID NOT NULL,
  match_id UUID NOT NULL,
  CONSTRAINT pk_match_mode PRIMARY KEY (game_id, match_id),
  FOREIGN KEY (match_id) REFERENCES matches (match_id) ON DELETE CASCADE,
  FOREIGN KEY (game_id) REFERENCES game_modes (game_id) ON DELETE RESTRICT
);

-- 5. Requires player_id and match_id to exist before creation.

CREATE TABLE match_participants(
  player_id UUID NOT NULL,
  match_id UUID NOT NULL,
  CONSTRAINT pk_match_participants PRIMARY KEY (player_id, match_id),
  FOREIGN KEY (player_id) REFERENCES players (player_id) ON DELETE RESTRICT,
  FOREIGN KEY (match_id) REFERENCES matches (match_id) ON DELETE CASCADE,
  entered_at TIMESTAMPTZ NOT NULL,
  left_at TIMESTAMPTZ,
  player_score INTEGER NOT NULL,
  CONSTRAINT chk_player_score_positive CHECK (player_score > 0)
);