<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/catalogo">
    LISTA DE TALLAS Y COLORES<xsl:apply-templates select="//color"/>
  </xsl:template>

  <xsl:template match="//color">
    Talla <xsl:value-of select="@talla"/> en color <xsl:value-of select="text()"/>
  </xsl:template>

</xsl:stylesheet>
