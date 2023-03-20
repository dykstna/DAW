<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
<xsl:template match="/catalogo">
    CATALOGO DE MI TIENDA<xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="//producto">
    Producto <xsl:value-of select="@descripcion"/> para <xsl:value-of select="modelo/@genero"/> - <xsl:value-of select="modelo/precio"/> €
  </xsl:template>

</xsl:stylesheet>
