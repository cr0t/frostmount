defmodule Frostmount.GameGenerator do
  # 500 uniq fantasy names (downloaded from https://opengameart.org/sites/default/files/names_txt.zip, and shuffled)
  @player_names ~w[Owach Ipeetu Ezizou Ajunee Ounil Acowee Toupee Oumac Ubebo Ogech Evuvu Wouvu Aviko Anouda Oupah
                   Keenee Ureeke Chotou Avoup Houlo Ijovee Ogeewa Ofeejo Oudeh Ubeelo Uleeco Ugobee Oufewo Adevi Devee
                   Ebeep Estic Akeel Ikizou Eceez Kujee Ojoum Uchuli Fouchi Micha Oukoz Afoka Oguzee Astiva Zestou
                   Ousoti Olesa Jouze Mobou Ewastu Vubou Geche Ichuci Zeemu Ugeeto Amesu Ouvac Avesu Ichece Afoul Usova
                   Esebe Wouve Emouwo Owice Neeki Ceelo Opust Echoj Afeeh Ouwust Opoupo Nicha Houst Tougo Mouku Oumal
                   Imamo Acero Vousou Omenu Ihocha Ezafe Oujev Bofee Ahecho Ugeva Upopa Rouhee Aboupi Seehou Owouh
                   Choucu Bouzi Ojecou Epumee Ouduga Ustul Zadee Ouchig Igicha Eheja Noubou Deerou Cheeza Steeva Estila
                   Ipotu Ouwer Apout Ozouch Chihou Peefou Ujifee Nouda Chami Emeew Odica Outoh Pochee Istiwi Couwu
                   Oheeci Astacu Juzee Ahuge Osuti Jeech Ecaji Ajisi Ulouni Obucou Waree Lovee Egase Ovolee Upuve
                   Uweeka Coulu Itutou Joujee Ifiwu Ewist Avoudi Woutu Mimee Zeest Efofo Echuga Alawou Ijefa Istol
                   Inewu Teejee Ceeva Heehe Fostou Okoma Ochof Agufi Uvouh Osoug Wouch Uruwo Esouj Usteec Chuvo Ehoun
                   Houfe Kamou Iheba Adeece Izouja Esado Ezanou Ucupo Dousti Ouhevu Evebu Jechu Ewoudi Ihaji Ezugee
                   Fouga Zutou Ceeme Souzo Umeesi Tousta Ouzifu Ujouc Uzeevu Wousu Ucheli Ostiro Stouz Veewe Stouwe
                   Usajo Ineezu Houwee Stuja Ofiwi Oulepa Ibomee Owana Ocopu Ceele Igoula Ejocou Stouco Ougouh Imeek
                   Jeekee Veefee Apeeja Idous Ahogi Zeewo Pawee Oudouc Ozoza Ouciz Ozoug Noudou Chouva Goune Emovee
                   Uchouf Meegee Owoupo Uwuhou Zeecha Ikeni Cavou Steli Ofumou Ofedee Ojafu Ubougi Souch Ceezi Oheezi
                   Ounira Uteeto Chuche Oucuc Ezoke Lecha Ibuvee Ceech Ujari Umede Uvolu Beevo Oustiw Steemo Owista
                   Awujou Ouvic Nobee Teene Ojowi Ehust Izetou Usacha Ozouca Icouzo Uchasi Neechu Oureni Akougu Jejee
                   Etagee Oveef Reefu Ugodu Olesou Lizou Achech Areez Ireelo Chosee Oufost Fouci Ozosou Noufu Mastee
                   Zalee Noume Omeko Doudou Ocufi Beedee Chazu Soufe Oreef Edokee Ikeek Ezeew Houche Oweego Ozeera
                   Ufezu Opasa Acara Oucumi Chast Wouki Esoupe Kusto Beera Ijestu Rouke Zeechi Egizo Stede Itech Efohee
                   Stuchu Chice Istif Uhomo Ateemi Uruchi Stepa Ufouc Kekou Aseet Udoufo Souhu Uchesi Awunu Fista Ohazi
                   Chucu Afice Stimou Nouno Inoup Ouwof Ikoure Feesto Ukacou Ovuwe Oulagi Ousor Ipibi Oudew Chawa
                   Weeche Akocho Usaro Arimou Ichim Uvece Acheew Abemou Akema Omojou Weeje Awoufe Steja Ineeb Boukee
                   Ileest Edusto Ousemu Inouf Doutu Utuch Echoli Chero Etezu Bouzou Toumou Aneegu Ounida Ucake Udees
                   Ejuro Ibutou Awuche Wosou Ugacu Wisou Stoke Oudec Rowou Zeepou Uzito Igeec Eweew Opoko Osawo Etuge
                   Achota Ozifi Ematou Umouz Chiru Adagou Peeme Chouz Mozee Jouch Ocechu Uzouz Teera Fouzi Oupope
                   Opezou Tuvee Ouveet Stato Rogee Ostac Ozagi Teeca Oujug Uzouw Enipu Sedou Ireera Ezaki Itapi Veeca
                   Woumo Uneer Neejou Cheej Chofo Umost Zouda Ostes Ouwees Otowou Oseez Ouvozu Chowo Oudouh Oulap Amaza
                   Leedu Isaha Rougi Demee Ozucee Oururi Ugist Oucahe Meewo Obeece Avupa Chaste Ceeco Cousti Efist
                   Omeej Neech Oukedu Utocee Veeri Steebi Okeewu Atubo Wicho Ikouz Osach Enizu Ecest Osezi Aweegu Agibe
                   Udada Hufou Edoudu Kostee Enife Oulep Aboga Chimu Astabo Oustug Ehulo Ofapo Peepa Choumu Uhoubu
                   Peero Oheene Uteer Stouto Oumeef Ekeede Aseef Egous Udeeho Owumo Esahee]

  @beast_heal_points 5
  @max_avatar_id 9

  def name(), do: Enum.random(@player_names)

  def avatar(), do: Enum.random(1..@max_avatar_id)

  def strength(), do: Enum.random((@beast_heal_points - 1)..(@beast_heal_points + 2))

  def heal_points(), do: @beast_heal_points
end
