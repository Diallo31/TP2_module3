<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
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
          <table>
            <thead>
              <tr>
                <th>Matricule</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Classe</th>
                <th>Email</th>
                <th>Moyenne</th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="//etudiant"/>
            </tbody>
          </table>
        </main>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="etudiant">
    <tr>
      <td><xsl:value-of select="@matricule"/></td>
      <td><xsl:value-of select="nom"/></td>
      <td><xsl:value-of select="prenom"/></td>
      <td><xsl:value-of select="@classe"/></td>
      <td><xsl:value-of select="email"/></td>
      <td><xsl:value-of select="format-number(moyenne, '0.00')"/></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>