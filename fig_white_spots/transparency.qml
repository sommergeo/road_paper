<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.28.1-Firenze" maxScale="0" styleCategories="AllStyleCategories" minScale="1e+08" hasScaleBasedVisibilityFlag="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>0</Searchable>
    <Private>0</Private>
  </flags>
  <temporal fetchMode="0" enabled="0" mode="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <elevation zscale="1" band="1" enabled="0" symbology="Line" zoffset="0">
    <data-defined-properties>
      <Option type="Map">
        <Option value="" name="name" type="QString"/>
        <Option name="properties"/>
        <Option value="collection" name="type" type="QString"/>
      </Option>
    </data-defined-properties>
    <profileLineSymbol>
      <symbol force_rhr="0" alpha="1" frame_rate="10" clip_to_extent="1" name="" type="line" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" name="name" type="QString"/>
            <Option name="properties"/>
            <Option value="collection" name="type" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer pass="0" class="SimpleLine" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" name="align_dash_pattern" type="QString"/>
            <Option value="square" name="capstyle" type="QString"/>
            <Option value="5;2" name="customdash" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="customdash_map_unit_scale" type="QString"/>
            <Option value="MM" name="customdash_unit" type="QString"/>
            <Option value="0" name="dash_pattern_offset" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="dash_pattern_offset_map_unit_scale" type="QString"/>
            <Option value="MM" name="dash_pattern_offset_unit" type="QString"/>
            <Option value="0" name="draw_inside_polygon" type="QString"/>
            <Option value="bevel" name="joinstyle" type="QString"/>
            <Option value="243,166,178,255" name="line_color" type="QString"/>
            <Option value="solid" name="line_style" type="QString"/>
            <Option value="0.6" name="line_width" type="QString"/>
            <Option value="MM" name="line_width_unit" type="QString"/>
            <Option value="0" name="offset" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="offset_map_unit_scale" type="QString"/>
            <Option value="MM" name="offset_unit" type="QString"/>
            <Option value="0" name="ring_filter" type="QString"/>
            <Option value="0" name="trim_distance_end" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="trim_distance_end_map_unit_scale" type="QString"/>
            <Option value="MM" name="trim_distance_end_unit" type="QString"/>
            <Option value="0" name="trim_distance_start" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="trim_distance_start_map_unit_scale" type="QString"/>
            <Option value="MM" name="trim_distance_start_unit" type="QString"/>
            <Option value="0" name="tweak_dash_pattern_on_corners" type="QString"/>
            <Option value="0" name="use_custom_dash" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="width_map_unit_scale" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </profileLineSymbol>
    <profileFillSymbol>
      <symbol force_rhr="0" alpha="1" frame_rate="10" clip_to_extent="1" name="" type="fill" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" name="name" type="QString"/>
            <Option name="properties"/>
            <Option value="collection" name="type" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer pass="0" class="SimpleFill" enabled="1" locked="0">
          <Option type="Map">
            <Option value="3x:0,0,0,0,0,0" name="border_width_map_unit_scale" type="QString"/>
            <Option value="243,166,178,255" name="color" type="QString"/>
            <Option value="bevel" name="joinstyle" type="QString"/>
            <Option value="0,0" name="offset" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="offset_map_unit_scale" type="QString"/>
            <Option value="MM" name="offset_unit" type="QString"/>
            <Option value="35,35,35,255" name="outline_color" type="QString"/>
            <Option value="no" name="outline_style" type="QString"/>
            <Option value="0.26" name="outline_width" type="QString"/>
            <Option value="MM" name="outline_width_unit" type="QString"/>
            <Option value="solid" name="style" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </profileFillSymbol>
  </elevation>
  <customproperties>
    <Option type="Map">
      <Option value="false" name="WMSBackgroundLayer" type="bool"/>
      <Option value="false" name="WMSPublishDataSourceUrl" type="bool"/>
      <Option value="0" name="embeddedWidgets/count" type="int"/>
      <Option value="Value" name="identify/format" type="QString"/>
    </Option>
  </customproperties>
  <pipe-data-defined-properties>
    <Option type="Map">
      <Option value="" name="name" type="QString"/>
      <Option name="properties"/>
      <Option value="collection" name="type" type="QString"/>
    </Option>
  </pipe-data-defined-properties>
  <pipe>
    <provider>
      <resampling zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour" maxOversampling="2" enabled="false"/>
    </provider>
    <rasterrenderer band="1" classificationMin="0.2689991" alphaBand="-1" nodataColor="255,255,255,255" opacity="1" classificationMax="0.9908151" type="singlebandpseudocolor">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>MinMax</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader maximumValue="0.99081509999999995" classificationMode="1" clip="0" minimumValue="0.26899909999999999" labelPrecision="4" colorRampType="INTERPOLATED">
          <colorramp name="[source]" type="gradient">
            <Option type="Map">
              <Option value="255,255,255,255" name="color1" type="QString"/>
              <Option value="255,255,255,0" name="color2" type="QString"/>
              <Option value="ccw" name="direction" type="QString"/>
              <Option value="0" name="discrete" type="QString"/>
              <Option value="gradient" name="rampType" type="QString"/>
              <Option value="rgb" name="spec" type="QString"/>
              <Option value="0.26;255,255,255,255;rgb;ccw:0.505508;255,255,255,226;rgb;ccw:0.604651;255,255,255,206;rgb;ccw:0.70257;255,255,255,167;rgb;ccw:0.802938;255,255,255,110;rgb;ccw:0.900857;255,255,255,40;rgb;ccw:0.952264;255,255,255,0;rgb;ccw" name="stops" type="QString"/>
            </Option>
          </colorramp>
          <item value="0.26899912953377" alpha="255" label="0,2690" color="#ffffff"/>
          <item value="0.283152352779361" alpha="255" label="0,2832" color="#ffffff"/>
          <item value="0.297305648206549" alpha="255" label="0,2973" color="#ffffff"/>
          <item value="0.31145887145214" alpha="255" label="0,3115" color="#ffffff"/>
          <item value="0.325612166879328" alpha="255" label="0,3256" color="#ffffff"/>
          <item value="0.339765390124919" alpha="255" label="0,3398" color="#ffffff"/>
          <item value="0.35391861337051" alpha="255" label="0,3539" color="#ffffff"/>
          <item value="0.368071980979296" alpha="255" label="0,3681" color="#ffffff"/>
          <item value="0.382225348588082" alpha="255" label="0,3822" color="#ffffff"/>
          <item value="0.396378716196867" alpha="255" label="0,3964" color="#ffffff"/>
          <item value="0.410531361989679" alpha="255" label="0,4105" color="#ffffff"/>
          <item value="0.424684729598465" alpha="255" label="0,4247" color="#ffffff"/>
          <item value="0.438838097207251" alpha="255" label="0,4388" color="#ffffff"/>
          <item value="0.452991464816036" alpha="255" label="0,4530" color="#ffffff"/>
          <item value="0.467144832424822" alpha="253" label="0,4671" color="#ffffff"/>
          <item value="0.481298200033608" alpha="251" label="0,4813" color="#ffffff"/>
          <item value="0.49545084582642" alpha="249" label="0,4955" color="#ffffff"/>
          <item value="0.509604213435205" alpha="246" label="0,5096" color="#ffffff"/>
          <item value="0.523757581043991" alpha="244" label="0,5238" color="#ffffff"/>
          <item value="0.537910948652777" alpha="242" label="0,5379" color="#ffffff"/>
          <item value="0.552064316261562" alpha="239" label="0,5521" color="#ffffff"/>
          <item value="0.566217683870348" alpha="237" label="0,5662" color="#ffffff"/>
          <item value="0.580371051479134" alpha="235" label="0,5804" color="#ffffff"/>
          <item value="0.594523697271946" alpha="232" label="0,5945" color="#ffffff"/>
          <item value="0.608677064880732" alpha="230" label="0,6087" color="#ffffff"/>
          <item value="0.622830432489517" alpha="227" label="0,6228" color="#ffffff"/>
          <item value="0.636983800098303" alpha="225" label="0,6370" color="#ffffff"/>
          <item value="0.651137167707089" alpha="221" label="0,6511" color="#ffffff"/>
          <item value="0.665290535315874" alpha="217" label="0,6653" color="#ffffff"/>
          <item value="0.679443181108686" alpha="213" label="0,6794" color="#ffffff"/>
          <item value="0.693596548717472" alpha="209" label="0,6936" color="#ffffff"/>
          <item value="0.707749916326257" alpha="204" label="0,7077" color="#ffffff"/>
          <item value="0.721903283935043" alpha="197" label="0,7219" color="#ffffff"/>
          <item value="0.736056651543829" alpha="189" label="0,7361" color="#ffffff"/>
          <item value="0.750210019152615" alpha="181" label="0,7502" color="#ffffff"/>
          <item value="0.7643633867614" alpha="173" label="0,7644" color="#ffffff"/>
          <item value="0.778516032554212" alpha="165" label="0,7785" color="#ffffff"/>
          <item value="0.792669400162998" alpha="154" label="0,7927" color="#ffffff"/>
          <item value="0.806822767771784" alpha="143" label="0,8068" color="#ffffff"/>
          <item value="0.820976135380569" alpha="132" label="0,8210" color="#ffffff"/>
          <item value="0.835129502989355" alpha="120" label="0,8351" color="#ffffff"/>
          <item value="0.849282870598141" alpha="109" label="0,8493" color="#ffffff"/>
          <item value="0.863435516390953" alpha="95" label="0,8634" color="#ffffff"/>
          <item value="0.877588883999738" alpha="81" label="0,8776" color="#ffffff"/>
          <item value="0.891742251608524" alpha="67" label="0,8917" color="#ffffff"/>
          <item value="0.90589561921731" alpha="53" label="0,9059" color="#ffffff"/>
          <item value="0.920048986826095" alpha="39" label="0,9200" color="#ffffff"/>
          <item value="0.934202354434881" alpha="24" label="0,9342" color="#ffffff"/>
          <item value="0.948355000227693" alpha="9" label="0,9484" color="#ffffff"/>
          <item value="0.962508367836479" alpha="0" label="0,9625" color="#ffffff"/>
          <item value="0.976661735445264" alpha="0" label="0,9767" color="#ffffff"/>
          <item value="0.99081510305405" alpha="0" label="0,9908" color="#ffffff"/>
          <rampLegendSettings maximumLabel="" direction="0" orientation="2" suffix="" prefix="" useContinuousLegend="1" minimumLabel="">
            <numericFormat id="basic">
              <Option type="Map">
                <Option name="decimal_separator" type="invalid"/>
                <Option value="6" name="decimals" type="int"/>
                <Option value="0" name="rounding_type" type="int"/>
                <Option value="false" name="show_plus" type="bool"/>
                <Option value="true" name="show_thousand_separator" type="bool"/>
                <Option value="false" name="show_trailing_zeros" type="bool"/>
                <Option name="thousand_separator" type="invalid"/>
              </Option>
            </numericFormat>
          </rampLegendSettings>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast contrast="0" brightness="0" gamma="1"/>
    <huesaturation saturation="0" colorizeGreen="128" colorizeStrength="100" invertColors="0" colorizeOn="0" colorizeRed="255" grayscaleMode="0" colorizeBlue="128"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
