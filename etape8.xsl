<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="seuil" select="10"/>
  <xsl:template match="/">
    <html lang="fr">
      <head><meta charset="UTF-8"/><title><xsl:value-of select="/promotion/@filiere"/></title><link rel="stylesheet" href="style.css"/></head>
      <body>
        <header><h1><xsl:value-of select="/promotion/@filiere"/></h1></header>
        <main>
          <div class="stats">
            <div class="carte"><span class="valeur"><xsl:value-of select="count(//etudiant)"/></span><span class="legende">étudiants</span></div>
            <div class="carte"><span class="valeur"><xsl:value-of select="count(//etudiant[sum(notes/note) div count(notes/note) >= $seuil])"/></span><span class="legende">admis</span></div>
            <div class="carte"><span class="valeur"><xsl:value-of select="format-number(sum(//note[@matiere='XML']) div count(//note[@matiere='XML']), '0.00')"/></span><span class="legende">moyenne en XML</span></div>
            <div class="carte"><span class="valeur"><xsl:value-of select="count(//etudiant[not(email)])"/></span><span class="legende">emails manquants</span></div>
          </div>
          <table>
            <thead><tr><th>Rang</th><th>Matricule</th><th>Nom</th><th>Prénom</th><th>Classe</th><th>Email</th><th>Moyenne</th><th>Résultat</th></tr></thead>
            <tbody>
              <xsl:apply-templates select="//etudiant">
                <xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending"/>
              </xsl:apply-templates>
            </tbody>
          </table>
        </main>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="etudiant">
    <tr>
      <td class="rang"><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="@matricule"/></td><td><xsl:value-of select="nom"/></td><td><xsl:value-of select="prenom"/></td><td><xsl:value-of select="@classe"/></td>
      <td><xsl:choose><xsl:when test="email"><xsl:value-of select="email"/></xsl:when><xsl:otherwise><span class="absent">non renseigné</span></xsl:otherwise></xsl:choose></td>
      <td class="moyenne"><xsl:value-of select="format-number(sum(notes/note) div count(notes/note), '0.00')"/></td>
      <td><xsl:choose><xsl:when test="sum(notes/note) div count(notes/note) >= $seuil"><span class="badge reussite">Admis</span></xsl:when><xsl:otherwise><span class="badge echec">À revoir</span></xsl:otherwise></xsl:choose></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>