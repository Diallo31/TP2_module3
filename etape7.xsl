<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Seuil de réussite : à modifier UNIQUEMENT ici -->
  <xsl:param name="seuil" select="10"/>

  <xsl:template match="/*">
    <html lang="fr">
      <head>
        <meta charset="UTF-8"/>
        <title><xsl:value-of select="@filiere"/></title>
        <link rel="stylesheet" href="style.css"/>
      </head>
      <body>
        <header>
          <h1><xsl:value-of select="@filiere"/></h1>
        </header>
        <main>

          <!-- Chiffres clés : chaque valeur est calculée par XPath -->
          <section class="chiffres">
            <div class="carte">
              <span class="valeur"><xsl:value-of select="count(//etudiant)"/></span>
              <span class="legende">Étudiants</span>
            </div>
            <div class="carte">
              <span class="valeur"><xsl:value-of select="count(//etudiant[number(moyenne) &gt;= $seuil])"/></span>
              <span class="legende">Admis</span>
            </div>
            <div class="carte">
              <span class="valeur"><xsl:value-of select="format-number(sum(//etudiant/moyenne) div count(//etudiant/moyenne), '0.00')"/></span>
              <span class="legende">Moyenne</span>
            </div>
            <div class="carte">
              <span class="valeur"><xsl:value-of select="count(//etudiant[normalize-space(email) = ''])"/></span>
              <span class="legende">Emails manquants</span>
            </div>
          </section>

          <table>
            <thead>
              <tr>
                <th>Rang</th>
                <th>Matricule</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Classe</th>
                <th>Email</th>
                <th>Moyenne</th>
                <th>Résultat</th>
              </tr>
            </thead>
            <tbody>
              <!-- Tri numérique décroissant sur la moyenne -->
              <xsl:apply-templates select="//etudiant">
                <xsl:sort select="moyenne" data-type="number" order="descending"/>
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
      <td><xsl:value-of select="@matricule"/></td>
      <td><xsl:value-of select="nom"/></td>
      <td><xsl:value-of select="prenom"/></td>
      <td><xsl:value-of select="@classe"/></td>

      <!-- Email absent (ou vide) : « non renseigné » -->
      <xsl:choose>
        <xsl:when test="normalize-space(email) = ''">
          <td class="manquant">non renseigné</td>
        </xsl:when>
        <xsl:otherwise>
          <td><xsl:value-of select="email"/></td>
        </xsl:otherwise>
      </xsl:choose>

      <td class="moyenne"><xsl:value-of select="format-number(moyenne, '0.00')"/></td>

      <!-- Résultat selon le seuil -->
      <td>
        <xsl:choose>
          <xsl:when test="number(moyenne) &gt;= $seuil">
            <span class="badge succes">Admis</span>
          </xsl:when>
          <xsl:otherwise>
            <span class="badge echec">À revoir</span>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>