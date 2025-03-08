# LC2Music
Synthesizer for the sonification of the BLS periodogram analysis from the lightcurves of the Kepler Exoplanet Object of Interest (KOI) archive. Data: STScI.

![LC2Music](https://github.com/user-attachments/assets/e2ed70af-edff-4830-86d2-faf954650ffd)

CONTENTS

- Jupyter notebook: LC2Music_Demo.ipynb
- Cabbage Synth: LC2Music_Synth_Flute.csd
- requirements.txt

LC2MUSIC INSTALLATION

- Download the data: https://archive.stsci.edu/pub/kepler/lightcurves/
- Install Cabbage following the instructions bellow
- Launch Cabbage, open LC2Music_Synth_Flute.csd, and press play
  Important note: Cabbage 2.9.0 requires CamelCase update via: File/Convert Identifiers to camelCase. Also change manually “PluginID” to “PluginId” to avoid warnings.
- Add your path to the downloaded lightcurves
- Run the Jupyter notebook LC2Music_Demo.ipynb with all the dependencies installed
- Enjoy the sonifications!

CABBAGE/CSOUND INSTALLATION

1- Download and install CSound 6.15 from: https://github.com/csound/csound/releases/tag/6.15.0

2- Download Cabbage from (current version 2.9.0): https://cabbageaudio.com/download/

3- Install only Cabbage from the downloaded Cabbage package.

Warning: Current Cabbage version 2.9.0 allows to optionally install the latest version of CSound. This default option should be unchecked not to overwrite CSound 6.15. Latests versions of CSound require additional plugins to work with the image CSound opcodes, so they should not be used.


Developer system info: Python 3.8.5 - Cabbage 2.5.0 - i7 macOS 10.15.7 - 32 GB - 1536 MB

