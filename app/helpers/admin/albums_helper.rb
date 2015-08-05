#encoding: utf-8

module Admin::AlbumsHelper
  def album_format_options
    [
      ['LP (Álbum)', 'LP'],
      ['CDS (Single)', 'CDS'],
      ['CDM (Maxi)', 'CDM'],
      ['EP', 'EP'],
      ['VA (Varios Artistas)', 'VA'],
      ['MX (Mixtape)', 'MX']
    ]
  end

  def album_trimester_options
    [
      ['1er. trimestre', 1],
      ['2º trimestre', 2],
      ['3er. trimestre', 3],
      ['4º trimestre', 4]
    ]
  end
end
