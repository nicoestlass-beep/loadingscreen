<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SITE-09 — Commandes Administration</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@300;400;500;600;700&family=IBM+Plex+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
:root {
  --red:       #b91c1c;
  --red-dim:   #450a0a;
  --red-light: #ef4444;
  --amber:     #d97706;
  --green:     #16a34a;
  --blue:      #1d4ed8;
  --cyan:      #0891b2;
  --purple:    #7c3aed;
  --bg:        #030507;
  --bg2:       #070a0e;
  --bg3:       #0c1018;
  --surface:   #111620;
  --border:    #1a2030;
  --border2:   #243045;
  --text:      #b8c4d8;
  --text-dim:  #4a5568;
  --text-hi:   #e2e8f0;
  --op:        #f59e0b;
  --admin:     #ef4444;
  --sadmin:    #dc2626;
  --tous:      #22c55e;
}

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }

body {
  font-family: 'IBM Plex Sans', sans-serif;
  background: var(--bg);
  color: var(--text);
  min-height: 100vh;
}

/* ── Noise texture ── */
body::after {
  content: '';
  position: fixed; inset: 0;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.035'/%3E%3C/svg%3E");
  pointer-events: none; z-index: 999;
}

/* ── LAYOUT ── */
.layout {
  display: grid;
  grid-template-columns: 240px 1fr;
  min-height: 100vh;
}

/* ── SIDEBAR ── */
.sidebar {
  background: var(--bg2);
  border-right: 1px solid var(--border);
  position: sticky;
  top: 0;
  height: 100vh;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

.sidebar::-webkit-scrollbar { width: 3px; }
.sidebar::-webkit-scrollbar-thumb { background: var(--border2); }

.brand {
  padding: 24px 20px 18px;
  border-bottom: 1px solid var(--border);
}

.brand-id {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 11px;
  color: var(--red-light);
  letter-spacing: 4px;
  font-weight: 600;
}

.brand-title {
  font-size: 17px;
  font-weight: 700;
  color: var(--text-hi);
  margin-top: 6px;
  line-height: 1.2;
}

.brand-sub {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 9px;
  color: var(--text-dim);
  margin-top: 5px;
  letter-spacing: 2px;
}

/* Légende permissions */
.perm-legend {
  padding: 14px 20px;
  border-bottom: 1px solid var(--border);
}

.perm-legend-title {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 9px;
  color: var(--text-dim);
  letter-spacing: 3px;
  margin-bottom: 10px;
}

.perm-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 4px 0;
  font-size: 11px;
  color: var(--text);
}

.perm-dot {
  width: 8px; height: 8px;
  border-radius: 50%;
  flex-shrink: 0;
}

.perm-dot.tous   { background: var(--tous); }
.perm-dot.op     { background: var(--op); }
.perm-dot.admin  { background: var(--admin); }
.perm-dot.sadmin { background: var(--sadmin); }

/* Nav */
.nav-group {
  padding: 12px 0 6px;
}

.nav-group-label {
  padding: 0 20px 6px;
  font-family: 'IBM Plex Mono', monospace;
  font-size: 9px;
  color: var(--text-dim);
  letter-spacing: 3px;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 20px;
  font-size: 12px;
  color: var(--text-dim);
  text-decoration: none;
  cursor: pointer;
  transition: all 0.15s;
  border-left: 2px solid transparent;
}

.nav-link:hover, .nav-link.active {
  color: var(--text-hi);
  background: rgba(185, 28, 28, 0.08);
  border-left-color: var(--red);
}

.nav-count {
  margin-left: auto;
  font-family: 'IBM Plex Mono', monospace;
  font-size: 9px;
  color: var(--text-dim);
  background: var(--border);
  padding: 1px 5px;
  border-radius: 2px;
}

/* ── MAIN ── */
.main {
  overflow-y: auto;
}

/* ── TOP BAR ── */
.topbar {
  position: sticky; top: 0; z-index: 50;
  background: rgba(3,5,7,0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--border);
  padding: 10px 36px;
  display: flex; align-items: center; gap: 12px;
}

.topbar-path {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 11px;
  color: var(--text-dim);
}

.topbar-path em { color: var(--red-light); font-style: normal; }

.topbar-search {
  margin-left: auto;
  position: relative;
}

.topbar-search input {
  background: var(--surface);
  border: 1px solid var(--border2);
  color: var(--text-hi);
  font-family: 'IBM Plex Mono', monospace;
  font-size: 11px;
  padding: 5px 10px 5px 28px;
  width: 200px;
  outline: none;
  transition: border-color 0.2s;
}

.topbar-search input:focus { border-color: var(--red); }
.topbar-search input::placeholder { color: var(--text-dim); }

.topbar-search::before {
  content: '⌕';
  position: absolute; left: 8px; top: 50%;
  transform: translateY(-50%);
  color: var(--text-dim);
  font-size: 14px;
  pointer-events: none;
}

/* ── CONTENT ── */
.content {
  padding: 36px;
  max-width: 1100px;
}

/* ── HERO ── */
.hero {
  margin-bottom: 40px;
  padding: 36px;
  background: var(--bg3);
  border: 1px solid var(--border2);
  position: relative;
  overflow: hidden;
}

.hero::before {
  content: 'CMD';
  position: absolute; right: -10px; top: -20px;
  font-family: 'IBM Plex Mono', monospace;
  font-size: 140px;
  font-weight: 700;
  color: rgba(185,28,28,0.04);
  pointer-events: none;
  line-height: 1;
  letter-spacing: -8px;
}

.hero-eyebrow {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 10px;
  color: var(--red);
  letter-spacing: 4px;
  margin-bottom: 10px;
}

.hero h1 {
  font-size: 30px;
  font-weight: 700;
  color: var(--text-hi);
  line-height: 1.2;
  margin-bottom: 10px;
}

.hero h1 span { color: var(--red-light); }

.hero p {
  font-size: 14px;
  color: var(--text-dim);
  max-width: 560px;
  line-height: 1.6;
}

/* ── SECTION ── */
.section {
  margin-bottom: 48px;
  scroll-margin-top: 60px;
}

.section-header {
  display: flex; align-items: center; gap: 10px;
  margin-bottom: 16px;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--border);
}

.section-bar {
  width: 3px; height: 18px;
  background: var(--red);
}

.section-title {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 12px;
  font-weight: 600;
  color: var(--text-hi);
  letter-spacing: 2px;
}

.section-desc {
  font-size: 12px;
  color: var(--text-dim);
  margin-left: auto;
}

/* ── COMMAND TABLE ── */
.cmd-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
}

.cmd-table thead tr {
  border-bottom: 1px solid var(--border2);
}

.cmd-table th {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 9px;
  letter-spacing: 2px;
  color: var(--text-dim);
  font-weight: 500;
  text-align: left;
  padding: 8px 12px;
  background: var(--bg3);
}

.cmd-table tbody tr {
  border-bottom: 1px solid var(--border);
  transition: background 0.1s;
}

.cmd-table tbody tr:hover { background: rgba(185,28,28,0.04); }
.cmd-table tbody tr.hidden { display: none; }

.cmd-table td {
  padding: 11px 12px;
  vertical-align: top;
}

.cmd-syntax {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 12px;
  color: #38bdf8;
  white-space: pre-wrap;
  word-break: break-all;
}

.cmd-args {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 11px;
  color: var(--amber);
}

.cmd-desc {
  font-size: 12px;
  color: var(--text);
  line-height: 1.5;
}

.cmd-desc .note {
  display: block;
  margin-top: 4px;
  font-size: 11px;
  color: var(--text-dim);
  font-style: italic;
}

.cmd-example {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 10px;
  color: #4ade80;
  margin-top: 5px;
  padding: 3px 7px;
  background: rgba(22,163,74,0.06);
  border-left: 2px solid rgba(22,163,74,0.3);
  display: inline-block;
}

/* Permissions */
.perm-tag {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 9px;
  font-weight: 600;
  padding: 3px 8px;
  letter-spacing: 1px;
  white-space: nowrap;
  border-radius: 2px;
}

.pt-tous   { background: rgba(34,197,94,0.1);  color: #4ade80; border: 1px solid rgba(34,197,94,0.2); }
.pt-op     { background: rgba(245,158,11,0.1); color: #fbbf24; border: 1px solid rgba(245,158,11,0.2); }
.pt-admin  { background: rgba(239,68,68,0.1);  color: #f87171; border: 1px solid rgba(239,68,68,0.2); }
.pt-sadmin { background: rgba(220,38,38,0.15); color: #ef4444; border: 1px solid rgba(220,38,38,0.3); }

/* ── ALERT BOX ── */
.alert {
  display: flex; gap: 12px; align-items: flex-start;
  padding: 12px 16px;
  margin-bottom: 16px;
  border: 1px solid var(--border2);
  border-left: 3px solid var(--red);
  background: rgba(185,28,28,0.04);
  font-size: 12px;
  color: var(--text);
  line-height: 1.5;
}

.alert-icon { flex-shrink: 0; font-size: 14px; }

/* ── STATS BAR ── */
.stats {
  display: flex; gap: 20px;
  padding: 14px 36px;
  border-bottom: 1px solid var(--border);
  background: var(--bg2);
}

.stat {
  display: flex; align-items: baseline; gap: 6px;
}

.stat-num {
  font-family: 'IBM Plex Mono', monospace;
  font-size: 18px;
  font-weight: 600;
  color: var(--text-hi);
}

.stat-label {
  font-size: 11px;
  color: var(--text-dim);
}

.stat-divider {
  width: 1px; background: var(--border);
  margin: 0 4px;
}
</style>
</head>
<body>

<div class="layout">

<!-- SIDEBAR -->
<aside class="sidebar">
  <div class="brand">
    <div class="brand-id">SITE-09 // CMD-REF</div>
    <div class="brand-title">Commandes<br>Administration</div>
    <div class="brand-sub">V4.0 — DOCUMENTATION INTERNE</div>
  </div>

  <div class="perm-legend">
    <div class="perm-legend-title">NIVEAUX D'ACCÈS</div>
    <div class="perm-item"><div class="perm-dot tous"></div>Tous les joueurs</div>
    <div class="perm-item"><div class="perm-dot op"></div>Operator</div>
    <div class="perm-item"><div class="perm-dot admin"></div>Admin</div>
    <div class="perm-item"><div class="perm-dot sadmin"></div>Superadmin</div>
  </div>

  <div class="nav-group">
    <div class="nav-group-label">SECTIONS</div>
    <a class="nav-link active" onclick="scrollTo('custom')">Commandes chat <span class="nav-count">13</span></a>
    <a class="nav-link" onclick="scrollTo('players')">Gestion joueurs <span class="nav-count">18</span></a>
    <a class="nav-link" onclick="scrollTo('sanctions')">Sanctions <span class="nav-count">11</span></a>
    <a class="nav-link" onclick="scrollTo('moderation')">Modération <span class="nav-count">10</span></a>
    <a class="nav-link" onclick="scrollTo('xp')">Système XP <span class="nav-count">5</span></a>
    <a class="nav-link" onclick="scrollTo('tech')">Pannes technicien <span class="nav-count">10</span></a>
    <a class="nav-link" onclick="scrollTo('darkrp')">DarkRP <span class="nav-count">8</span></a>
    <a class="nav-link" onclick="scrollTo('joueurs')">Commandes joueurs <span class="nav-count">4</span></a>
  </div>
</aside>

<!-- MAIN -->
<div class="main">

  <!-- TOP BAR -->
  <div class="topbar">
    <div class="topbar-path">SITE-09 / <em>DOCUMENTATION</em> / COMMANDES ADMIN</div>
    <div class="topbar-search">
      <input type="text" placeholder="Rechercher une commande..." id="search-input" oninput="filterCommands(this.value)">
    </div>
  </div>

  <!-- STATS -->
  <div class="stats">
    <div class="stat"><span class="stat-num">79</span><span class="stat-label">commandes total</span></div>
    <div class="stat-divider"></div>
    <div class="stat"><span class="stat-num">8</span><span class="stat-label">catégories</span></div>
    <div class="stat-divider"></div>
    <div class="stat"><span class="stat-num" style="color:#4ade80">13</span><span class="stat-label">accessibles à tous</span></div>
    <div class="stat-divider"></div>
    <div class="stat"><span class="stat-num" style="color:#fbbf24">24</span><span class="stat-label">operator+</span></div>
    <div class="stat-divider"></div>
    <div class="stat"><span class="stat-num" style="color:#f87171">28</span><span class="stat-label">admin+</span></div>
    <div class="stat-divider"></div>
    <div class="stat"><span class="stat-num" style="color:#ef4444">14</span><span class="stat-label">superadmin</span></div>
  </div>

  <div class="content">

    <!-- HERO -->
    <div class="hero">
      <div class="hero-eyebrow">// RÉFÉRENCE TECHNIQUE</div>
      <h1>Commandes <span>Administration</span></h1>
      <p>Documentation complète de toutes les commandes disponibles sur le serveur Site-09. Organisées par catégorie avec niveaux de permission.</p>
    </div>

    <div class="alert">
      <div class="alert-icon">⚠</div>
      <div>Toute action effectuée avec des commandes admin est enregistrée dans les logs serveur. L'abus de commandes administratives entraîne le retrait des droits et un ban.</div>
    </div>

    <!-- ══ COMMANDES CHAT PERSONNALISÉES ══ -->
    <div class="section" id="s-custom">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">COMMANDES CHAT — SYSTÈME SITE-09</div>
        <div class="section-desc">Tapées directement dans le chat</div>
      </div>
      <table class="cmd-table" data-section="custom">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="!admin !staff mode staff god noclip cloak esp">
            <td><div class="cmd-syntax">!admin</div><div class="cmd-args">alias: !staff / !staffmode</div></td>
            <td><div class="cmd-desc">Active/désactive le mode staff. Donne God mode, Noclip, Cloak (invisibilité) et ESP (voir les noms à travers les murs).<span class="note">Toggle — refaire la commande pour désactiver</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!spectate spectate joueur observer 3e personne">
            <td><div class="cmd-syntax">!spectate &lt;nom&gt;</div></td>
            <td><div class="cmd-desc">Spectate un joueur en vue 3e personne sans transmettre les inputs. Retaper la commande ou ne pas préciser de nom pour arrêter.
              <span class="cmd-example">!spectate Paprika</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!voix !voice !vocal who is speaking vocal micro">
            <td><div class="cmd-syntax">!voix</div><div class="cmd-args">alias: !voice / !vocal</div></td>
            <td><div class="cmd-desc">Affiche un indicateur HUD et en 3D de qui parle en vocal. Inclut le nom RP, le nom Steam et le job DarkRP.<span class="note">Toggle ON/OFF</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!xpmenu !xp exp niveau gestionnaire">
            <td><div class="cmd-syntax">!xpmenu</div><div class="cmd-args">alias: !xp</div></td>
            <td><div class="cmd-desc">Ouvre le gestionnaire graphique XP. Affiche tous les joueurs connectés avec leur niveau, XP, barre de progression et boutons d'action rapide.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="!resetxpall reset xp tous joueurs niveau 1">
            <td><div class="cmd-syntax">!resetxpall</div></td>
            <td><div class="cmd-desc">Remet le niveau et l'XP de <strong>tous</strong> les joueurs connectés à 1/0. Action globale irréversible.<span class="note">⚠ Notifie tous les joueurs</span></div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="!panne créer panne maintenance technicien">
            <td><div class="cmd-syntax">!panne [type]</div></td>
            <td><div class="cmd-desc">Crée une panne devant l'admin. Types disponibles : electric, gas, reactor, circuit, pressure, cooling, terminal, overload, radio, alarm, lock, signal
              <span class="cmd-example">!panne reactor Instabilité critique</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="!pannes !panneinfo liste pannes actives">
            <td><div class="cmd-syntax">!pannes</div><div class="cmd-args">alias: !panneinfo</div></td>
            <td><div class="cmd-desc">Affiche l'interface liste des pannes actives avec type, position, durée et statistiques des techniciens.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!pannestop supprimer toutes pannes stop">
            <td><div class="cmd-syntax">!pannestop</div></td>
            <td><div class="cmd-desc">Supprime immédiatement toutes les pannes actives sur la map.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="!son url jouer musique son audio">
            <td><div class="cmd-syntax">!son &lt;url&gt; [volume]</div><div class="cmd-args">Volume: 0 → 2 (défaut: 0.7)</div></td>
            <td><div class="cmd-desc">Joue un son depuis une URL directe (.mp3/.ogg/.wav) pour tous les joueurs connectés. Les nouveaux connectés reçoivent le son automatiquement.
              <span class="cmd-example">!son https://example.com/alarm.mp3 1.2</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!sonstop arrêter stopper son musique">
            <td><div class="cmd-syntax">!sonstop</div><div class="cmd-args">alias: !stopson</div></td>
            <td><div class="cmd-desc">Stoppe le son en cours pour tous les joueurs.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!sonvolume volume régler global">
            <td><div class="cmd-syntax">!sonvolume &lt;valeur&gt;</div><div class="cmd-args">0.0 → 2.0</div></td>
            <td><div class="cmd-desc">Modifie le volume global du son en cours pour tous les joueurs.
              <span class="cmd-example">!sonvolume 0.5</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!sonmenu menu son interface">
            <td><div class="cmd-syntax">!sonmenu</div><div class="cmd-args">alias: !sonliste / !sons</div></td>
            <td><div class="cmd-desc">Ouvre l'interface graphique du lecteur audio (URL personnalisée, favoris, volume global).</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="!ticket tickets aide /// rapport signalement">
            <td><div class="cmd-syntax">!ticket</div><div class="cmd-args">alias: !tickets / ///</div></td>
            <td><div class="cmd-desc">Ouvre le formulaire de ticket. Les admins reçoivent une popup avec les informations et boutons d'action.<span class="note">Accessible à tous les joueurs</span></div></td>
            <td><span class="perm-tag pt-tous">TOUS</span></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ══ GESTION JOUEURS ULX ══ -->
    <div class="section" id="s-players">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">ULX — GESTION JOUEURS</div>
        <div class="section-desc">Téléportation, états, buffs</div>
      </div>
      <table class="cmd-table" data-section="players">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="goto teleporter admin joueur position">
            <td><div class="cmd-syntax">ulx goto &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Téléporte l'admin à la position du joueur ciblé.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="bring amener ramener téléporter chez admin">
            <td><div class="cmd-syntax">ulx bring &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Téléporte un joueur à la position de l'admin.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="return retourner renvoyer position précédente">
            <td><div class="cmd-syntax">ulx return &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Renvoie le joueur à sa position avant le dernier goto/bring.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="spectate observer regarder joueur">
            <td><div class="cmd-syntax">ulx spectate &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Spectate un joueur en vue première personne (ULX natif).<span class="note">Préférer !spectate qui évite la transmission d'inputs</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="hp health vie modifier">
            <td><div class="cmd-syntax">ulx hp &lt;joueur&gt; &lt;valeur&gt;</div><div class="cmd-args">1 → 999</div></td>
            <td><div class="cmd-desc">Définit les points de vie d'un joueur.
              <span class="cmd-example">ulx hp Paprika 100</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="armor armure bouclier modifier">
            <td><div class="cmd-syntax">ulx armor &lt;joueur&gt; &lt;valeur&gt;</div></td>
            <td><div class="cmd-desc">Définit l'armure d'un joueur (0-100).</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="god mode dieu invincible">
            <td><div class="cmd-syntax">ulx god &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Active le mode dieu (invincibilité) sur un joueur.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="ungod désactiver dieu mode invincible">
            <td><div class="cmd-syntax">ulx ungod &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Désactive le mode dieu sur un joueur.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="cloak cloaker invisible rendre invisible">
            <td><div class="cmd-syntax">ulx cloak &lt;joueur&gt; [alpha]</div><div class="cmd-args">alpha: 0 (invisible) → 255 (visible)</div></td>
            <td><div class="cmd-desc">Rend un joueur invisible. Alpha 0 = totalement invisible.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="uncloak visible rendre visible">
            <td><div class="cmd-syntax">ulx uncloak &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Rend un joueur visible à nouveau.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="freeze immobiliser bloquer joueur">
            <td><div class="cmd-syntax">ulx freeze &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Immobilise complètement un joueur.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="unfreeze libérer dégeler joueur">
            <td><div class="cmd-syntax">ulx unfreeze &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Libère un joueur immobilisé.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="ignite enflammer feu brûler joueur">
            <td><div class="cmd-syntax">ulx ignite &lt;joueur&gt; [durée]</div></td>
            <td><div class="cmd-desc">Enflamme un joueur. Durée optionnelle en secondes.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="unignite éteindre feu brûler joueur">
            <td><div class="cmd-syntax">ulx unignite &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Éteint un joueur en feu.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="blind aveugler blackout noir écran">
            <td><div class="cmd-syntax">ulx blind &lt;joueur&gt; [0-255]</div></td>
            <td><div class="cmd-desc">Aveugle un joueur. 255 = noir total, 0 = normal.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="slap gifler projeter pousser dégâts">
            <td><div class="cmd-syntax">ulx slap &lt;joueur&gt; [dégâts]</div></td>
            <td><div class="cmd-desc">Projette un joueur avec une force aléatoire. Dégâts optionnels.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="slay tuer tuer instantanément mort">
            <td><div class="cmd-syntax">ulx slay &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Tue instantanément un joueur.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="strip retirer désarmer armes inventaire">
            <td><div class="cmd-syntax">ulx strip &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Retire toutes les armes de l'inventaire d'un joueur.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ══ SANCTIONS ══ -->
    <div class="section" id="s-sanctions">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">ULX — SANCTIONS</div>
        <div class="section-desc">Warn, kick, ban, jail</div>
      </div>
      <table class="cmd-table" data-section="sanctions">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="warn avertissement warning enregistrer">
            <td><div class="cmd-syntax">ulx warn &lt;joueur&gt; &lt;raison&gt;</div></td>
            <td><div class="cmd-desc">Avertissement formel enregistré dans les logs. Le joueur est notifié.
              <span class="cmd-example">ulx warn Paprika RDM sur un Classe-D</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="kick expulser virer sortir joueur">
            <td><div class="cmd-syntax">ulx kick &lt;joueur&gt; &lt;raison&gt;</div></td>
            <td><div class="cmd-desc">Expulse un joueur du serveur. Il peut reconnecté immédiatement.
              <span class="cmd-example">ulx kick Paprika FailRP répété</span></div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="jail prison emprisonner enfermer joueur">
            <td><div class="cmd-syntax">ulx jail &lt;joueur&gt; [durée]</div><div class="cmd-args">durée en secondes (0 = permanent)</div></td>
            <td><div class="cmd-desc">Emprisonne un joueur en place sans le déplacer.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="unjail libérer prison joueur">
            <td><div class="cmd-syntax">ulx unjail &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Libère un joueur emprisonné par ulx jail.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="mute muet micro vocal couper son">
            <td><div class="cmd-syntax">ulx mute &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Coupe le micro vocal d'un joueur. Le chat textuel reste actif.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="unmute démuet réactiver micro vocal">
            <td><div class="cmd-syntax">ulx unmute &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Réactive le micro d'un joueur muté.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="gag bâillon chat textuel interdire">
            <td><div class="cmd-syntax">ulx gag &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Interdit le chat textuel à un joueur. Le vocal reste actif.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="ungag débâillonner chat textuel réactiver">
            <td><div class="cmd-syntax">ulx ungag &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Réactive le chat textuel d'un joueur bâillonné.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="ban bannir interdire temporaire permanent minutes">
            <td><div class="cmd-syntax">ulx ban &lt;joueur&gt; &lt;minutes&gt; &lt;raison&gt;</div><div class="cmd-args">0 minutes = ban permanent</div></td>
            <td><div class="cmd-desc">Banni un joueur connecté. 0 = permanent.
              <span class="cmd-example">ulx ban Paprika 60 RDM massif</span>
              <span class="cmd-example">ulx ban Paprika 0 Cheat détecté</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="unban lever ban débannir steamid">
            <td><div class="cmd-syntax">ulx unban &lt;SteamID&gt;</div><div class="cmd-args">Format: STEAM_0:0:000000</div></td>
            <td><div class="cmd-desc">Lève le ban d'un joueur par son SteamID (joueur hors ligne possible).
              <span class="cmd-example">ulx unban STEAM_0:0:635551776</span></div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="banid ban hors ligne offline steamid">
            <td><div class="cmd-syntax">ulx banid &lt;SteamID&gt; &lt;minutes&gt; &lt;raison&gt;</div></td>
            <td><div class="cmd-desc">Banni un joueur hors ligne par son SteamID.
              <span class="cmd-example">ulx banid STEAM_0:0:635551776 1440 Harcèlement</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ══ MODERATION ══ -->
    <div class="section" id="s-moderation">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">ULX — MODÉRATION AVANCÉE</div>
        <div class="section-desc">Groupes, messages, serveur</div>
      </div>
      <table class="cmd-table" data-section="moderation">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="who info joueur steamid groupe informations">
            <td><div class="cmd-syntax">ulx who &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Affiche les informations complètes d'un joueur : SteamID, groupe, warns, temps de jeu, etc.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="psay message privé admin joueur">
            <td><div class="cmd-syntax">ulx psay &lt;joueur&gt; &lt;message&gt;</div></td>
            <td><div class="cmd-desc">Envoie un message privé visible uniquement par le joueur ciblé. Indiqué comme venant d'un admin.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="csay message centre écran annonce broadcast">
            <td><div class="cmd-syntax">ulx csay &lt;couleur&gt; &lt;message&gt;</div></td>
            <td><div class="cmd-desc">Affiche un message centré à l'écran pour tous les joueurs.
              <span class="cmd-example">ulx csay red ALERTE : Brèche SCP-106 en cours</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="tsay message bas écran tous broadcast">
            <td><div class="cmd-syntax">ulx tsay &lt;couleur&gt; &lt;message&gt;</div></td>
            <td><div class="cmd-desc">Affiche un message en bas de l'écran pour tous les joueurs.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="ssay message anonyme admin chat broadcast">
            <td><div class="cmd-syntax">ulx ssay &lt;message&gt;</div></td>
            <td><div class="cmd-desc">Message visible par tous sans révéler l'identité de l'admin.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="noclip voler noclip joueur">
            <td><div class="cmd-syntax">ulx noclip &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Active/désactive le noclip sur un joueur.<span class="note">Pour soi-même : utiliser !admin en mode staff</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="adduser groupe donner droits admin operator">
            <td><div class="cmd-syntax">ulx adduser &lt;joueur&gt; &lt;groupe&gt;</div><div class="cmd-args">groupes: operator / admin / superadmin</div></td>
            <td><div class="cmd-desc">Ajoute un joueur à un groupe avec droits persistants.
              <span class="cmd-example">ulx adduser Paprika operator</span></div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="removeuser retirer groupe droits admin">
            <td><div class="cmd-syntax">ulx removeuser &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Retire les droits admin d'un joueur (retour au groupe user).</div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="map changer carte serveur changerlevel">
            <td><div class="cmd-syntax">ulx map &lt;carte&gt;</div></td>
            <td><div class="cmd-desc">Change la carte du serveur. Déconnecte tous les joueurs.
              <span class="cmd-example">ulx map rp_site09_v4</span></div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="rcon console serveur commande distante">
            <td><div class="cmd-syntax">ulx rcon &lt;commande&gt;</div></td>
            <td><div class="cmd-desc">Exécute une commande RCON directement sur le serveur dédié.</div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ══ XP ══ -->
    <div class="section" id="s-xp">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">SYSTÈME XP & NIVEAUX</div>
        <div class="section-desc">Progression des joueurs</div>
      </div>
      <table class="cmd-table" data-section="xp">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="setlevel définir niveau joueur xp">
            <td><div class="cmd-syntax">fc_setlevel [joueur] &lt;niveau&gt;</div><div class="cmd-args">1 → 50. Sans joueur = soi-même</div></td>
            <td><div class="cmd-desc">Définit le niveau d'un joueur. Remet son XP à 0.
              <span class="cmd-example">fc_setlevel Paprika 25</span></div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="givexp donner xp points experience">
            <td><div class="cmd-syntax">fc_givexp [joueur] &lt;montant&gt;</div></td>
            <td><div class="cmd-desc">Donne des points XP à un joueur. Peut déclencher un level-up.
              <span class="cmd-example">fc_givexp Paprika 1000</span></div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="resetxp reset xp joueur niveau 1">
            <td><div class="cmd-syntax">fc_resetxp [joueur]</div></td>
            <td><div class="cmd-desc">Remet le niveau d'un joueur à 1 et son XP à 0.</div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
          <tr data-search="xpmenu gestionnaire interface tous joueurs">
            <td><div class="cmd-syntax">!xpmenu (chat) / fc_xpmenu (console)</div></td>
            <td><div class="cmd-desc">Ouvre le gestionnaire graphique XP avec tableau de tous les joueurs, barres de progression et boutons d'action.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="resetxpall reset tous xp global niveau 1">
            <td><div class="cmd-syntax">!resetxpall (chat)</div></td>
            <td><div class="cmd-desc">Reset le niveau et XP de <strong>tous</strong> les joueurs connectés à 1/0 avec notification globale.</div></td>
            <td><span class="perm-tag pt-sadmin">SUPERADMIN</span></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ══ PANNES ══ -->
    <div class="section" id="s-tech">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">PANNES TECHNICIEN</div>
        <div class="section-desc">Système de maintenance du site</div>
      </div>
      <table class="cmd-table" data-section="tech">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="panne créer type label maintenance">
            <td><div class="cmd-syntax">s09_panne_creer &lt;type&gt; [label]</div><div class="cmd-args">Types: electric, gas, reactor, circuit, pressure, cooling, terminal, overload, radio, alarm, lock, signal</div></td>
            <td><div class="cmd-desc">Crée une panne devant l'admin avec un label optionnel.
              <span class="cmd-example">s09_panne_creer reactor Instabilité critique</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="panne aléatoire random plusieurs map">
            <td><div class="cmd-syntax">s09_panne_aleatoire [nb]</div><div class="cmd-args">1 → 20 pannes (défaut: 1)</div></td>
            <td><div class="cmd-desc">Crée des pannes aléatoires réparties sur la map.
              <span class="cmd-example">s09_panne_aleatoire 5</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="panne sur joueur position">
            <td><div class="cmd-syntax">s09_panne_sur &lt;pseudo&gt; [type]</div></td>
            <td><div class="cmd-desc">Crée une panne devant un joueur spécifique.
              <span class="cmd-example">s09_panne_sur Paprika electric</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="panne liste actives afficher interface">
            <td><div class="cmd-syntax">s09_panne_liste</div><div class="cmd-args">alias: !pannes / !panneinfo</div></td>
            <td><div class="cmd-desc">Interface graphique listant toutes les pannes actives avec position, durée et statistiques.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="panne retirer supprimer index entité">
            <td><div class="cmd-syntax">s09_panne_retirer &lt;entIdx&gt;</div></td>
            <td><div class="cmd-desc">Supprime une panne spécifique par son index d'entité (visible dans la liste).</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="panne stop toutes supprimer nettoyer">
            <td><div class="cmd-syntax">s09_panne_retirer_toutes</div><div class="cmd-args">alias: !pannestop</div></td>
            <td><div class="cmd-desc">Supprime toutes les pannes actives sur la map instantanément.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="panne tp téléporter position aller">
            <td><div class="cmd-syntax">s09_panne_tp &lt;entIdx&gt;</div></td>
            <td><div class="cmd-desc">Téléporte l'admin directement vers une panne spécifique.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="panne types liste types disponibles">
            <td><div class="cmd-syntax">s09_panne_types</div></td>
            <td><div class="cmd-desc">Affiche la liste des 12 types de pannes disponibles avec leur mini-jeu associé.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="panne info statistiques top techniciens">
            <td><div class="cmd-syntax">s09_panne_info</div></td>
            <td><div class="cmd-desc">Statistiques globales : pannes créées/résolues/expirées, stats par type, top 5 techniciens.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="donner outils technicien ingénieur tools">
            <td><div class="cmd-syntax">s09_donner_outils [joueur]</div></td>
            <td><div class="cmd-desc">Donne les 4 outils technicien (multimètre, clé gaz, scanner, chalumeau) à un joueur ou à soi-même.
              <span class="cmd-example">s09_donner_outils Paprika</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ══ DARKRP ══ -->
    <div class="section" id="s-darkrp">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">COMMANDES DARKRP</div>
        <div class="section-desc">Jobs, argent, inventaire</div>
      </div>
      <table class="cmd-table" data-section="darkrp">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="setjob job changer métier forcer">
            <td><div class="cmd-syntax">!setjob &lt;joueur&gt; &lt;command&gt;</div></td>
            <td><div class="cmd-desc">Force le job d'un joueur vers un poste spécifique (commande DarkRP).
              <span class="cmd-example">!setjob Paprika ut_agent</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="setmoney argent définir monnaie économie">
            <td><div class="cmd-syntax">!setmoney &lt;joueur&gt; &lt;montant&gt;</div></td>
            <td><div class="cmd-desc">Définit le solde d'un joueur.
              <span class="cmd-example">!setmoney Paprika 5000</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="addmoney donner argent ajouter monnaie">
            <td><div class="cmd-syntax">!addmoney &lt;joueur&gt; &lt;montant&gt;</div></td>
            <td><div class="cmd-desc">Ajoute de l'argent au solde actuel d'un joueur.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="takemoney prendre retirer argent monnaie">
            <td><div class="cmd-syntax">!takemoney &lt;joueur&gt; &lt;montant&gt;</div></td>
            <td><div class="cmd-desc">Retire de l'argent du solde d'un joueur.</div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="setname nom rp changer pseudo">
            <td><div class="cmd-syntax">!setname &lt;joueur&gt; &lt;nom&gt;</div></td>
            <td><div class="cmd-desc">Modifie le nom RP d'un joueur.
              <span class="cmd-example">!setname Paprika Agent-4419</span></div></td>
            <td><span class="perm-tag pt-admin">ADMIN</span></td>
          </tr>
          <tr data-search="arrest arrêter menotter darkrp">
            <td><div class="cmd-syntax">!arrest &lt;joueur&gt; &lt;durée&gt;</div><div class="cmd-args">durée en secondes</div></td>
            <td><div class="cmd-desc">Arrête un joueur via DarkRP (met en prison). Nécessite d'être Police/UT.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="unarrest libérer prison darkrp">
            <td><div class="cmd-syntax">!unarrest &lt;joueur&gt;</div></td>
            <td><div class="cmd-desc">Libère un joueur arrêté par DarkRP.</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
          <tr data-search="wanted wanted recherché darkrp criminel">
            <td><div class="cmd-syntax">!wanted &lt;joueur&gt; &lt;raison&gt;</div></td>
            <td><div class="cmd-desc">Marque un joueur comme recherché dans DarkRP (visible sur le HUD de l'UT).</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ══ JOUEURS ══ -->
    <div class="section" id="s-joueurs">
      <div class="section-header">
        <div class="section-bar"></div>
        <div class="section-title">COMMANDES JOUEURS</div>
        <div class="section-desc">Accessibles à tous</div>
      </div>
      <table class="cmd-table" data-section="joueurs">
        <thead><tr><th>COMMANDE</th><th>DESCRIPTION</th><th>PERMISSION</th></tr></thead>
        <tbody>
          <tr data-search="ticket aide signalement rapport problème">
            <td><div class="cmd-syntax">!ticket</div><div class="cmd-args">alias: !tickets / ///&lt;message&gt;</div></td>
            <td><div class="cmd-desc">Ouvre un formulaire de signalement. Un admin disponible reçoit une notification en temps réel.<span class="note">Seul moyen officiel de contacter un admin en jeu</span></div></td>
            <td><span class="perm-tag pt-tous">TOUS</span></td>
          </tr>
          <tr data-search="reglement rules règles site web documentation">
            <td><div class="cmd-syntax">!reglement</div><div class="cmd-args">alias: !rules / !web / !site</div></td>
            <td><div class="cmd-desc">Ouvre la page règlement et documentation du serveur dans un navigateur intégré.</div></td>
            <td><span class="perm-tag pt-tous">TOUS</span></td>
          </tr>
          <tr data-search="volume son local perso personnel">
            <td><div class="cmd-syntax">cs_myvolume &lt;valeur&gt;</div><div class="cmd-args">Console uniquement. 0.0 → 2.0</div></td>
            <td><div class="cmd-desc">Règle son propre volume pour les sons du serveur sans affecter les autres joueurs.
              <span class="cmd-example">cs_myvolume 0.5</span></div></td>
            <td><span class="perm-tag pt-tous">TOUS</span></td>
          </tr>
          <tr data-search="toggle ct ticket réception admin operator">
            <td><div class="cmd-syntax">ct_toggle</div><div class="cmd-args">Console uniquement</div></td>
            <td><div class="cmd-desc">Active/désactive la réception des tickets admin (pour les admins qui ne veulent temporairement plus recevoir de popups).</div></td>
            <td><span class="perm-tag pt-op">OPERATOR</span></td>
          </tr>
        </tbody>
      </table>
    </div>

  </div><!-- /content -->
</div><!-- /main -->
</div><!-- /layout -->

<script>
function scrollTo(section) {
  const el = document.getElementById('s-' + section);
  if (el) el.scrollIntoView({ behavior: 'smooth' });
  document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
  event.currentTarget.classList.add('active');
}

function filterCommands(query) {
  const q = query.toLowerCase().trim();
  document.querySelectorAll('.cmd-table tbody tr').forEach(row => {
    if (!q) { row.classList.remove('hidden'); return; }
    const search = (row.getAttribute('data-search') || '') + ' ' +
                   row.textContent.toLowerCase();
    row.classList.toggle('hidden', !search.includes(q));
  });
}
</script>
</body>
</html>
