<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="//producto">
    PRODUCTO
    Descripción: <xsl:value-of select="@descripcion"/>
    Género: <xsl:value-of select="modelo/@genero"/>
    ID: <xsl:value-of select="modelo/id_modelo"/>
    Precio: <xsl:value-of select="modelo/precio"/> €
  </xsl:template>
</xsl:stylesheet>
