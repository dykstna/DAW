<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/root">
    CURSOS QUE SE IMPARTEN MARTES Y JUEVES (T-Th)
    <xsl:for-each select="course[days='T-Th']">
      <xsl:value-of select="position()"/>.- <xsl:value-of select="title"/> - Profesor: <xsl:value-of select="instructor"/>. 
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
