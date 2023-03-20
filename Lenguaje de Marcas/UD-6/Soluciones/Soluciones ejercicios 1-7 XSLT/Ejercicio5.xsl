<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/root">
    AULAS DE CURSOS<xsl:apply-templates select="//place"/>
  </xsl:template>

<xsl:template match="//place">
    Edificio: <xsl:value-of select="building"/> -  Aula: <xsl:value-of select="room"/>
  </xsl:template>
</xsl:stylesheet>
