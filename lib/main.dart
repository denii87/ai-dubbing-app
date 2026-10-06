import 'package:flutter/material.dart';

void main() {
  runApp(const AIDubbingApp());
}

class AIDubbingApp extends StatelessWidget {
  const AIDubbingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI DUBBING PRO',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F111A),
        cardColor: const Color(0xFF1A1D2B),
      ),
      home: const DubbingWorkspaceScreen(),
    );
  }
}

class DubbingWorkspaceScreen extends StatefulWidget {
  const DubbingWorkspaceScreen({super.key});

  @override
  State<DubbingWorkspaceScreen> createState() => _DubbingWorkspaceScreenState();
}

class _DubbingWorkspaceScreenState extends State<DubbingWorkspaceScreen> {
  double _originalVolume = 15;
  double _ttsVolume = 100;
  bool _removeVocal = false;
  String _selectedSpeaker = 'sreymom';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.flash_on, color: Colors.cyanAccent),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'AI DUBBING PRO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.cyanAccent),
            ),
            Text(
              'នៅសល់ ២ ថ្ងៃ',
              style: TextStyle(fontSize: 12, color: Colors.greenAccent),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
          IconButton(icon: const Icon(Icons.g_translate), onPressed: () {}),
          IconButton(icon: const Icon(Icons.light_mode), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'បកប្រែវីដេអូស្វ័យប្រវត្តិតាមរយៈ Edge TTS (ពិសិដ្ឋ & ស្រីមុំ)',
              style: TextStyle(color: Colors.white70, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Video Picker Card
            _buildSelectionCard(
              icon: Icons.video_file,
              title: 'វីដេអូដើម (Original Video)',
              subtitle: 'មិនទាន់ជ្រើសរើសវីដេអូនៅឡើយទេ',
              onTap: () {},
            ),
            const SizedBox(height: 12),

            // SRT Subtitle Picker Card
            _buildSelectionCard(
              icon: Icons.subtitles,
              title: 'ឯកសារអក្សររត់ (SRT Subtitles)',
              subtitle: 'មិនទាន់ជ្រើសរើសឯកសារ SRT នៅឡើយ...',
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Volume Mixer Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.volume_up, color: Colors.cyanAccent, size: 20),
                        SizedBox(width: 8),
                        Text('កម្រិតសំឡេង (Volume Mixer)', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('សំឡេងដើម (Original)', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('${_originalVolume.toInt()}%', style: const TextStyle(color: Colors.cyanAccent)),
                      ],
                    ),
                    Slider(
                      value: _originalVolume,
                      min: 0,
                      max: 100,
                      activeColor: Colors.cyanAccent,
                      onChanged: (val) => setState(() => _originalVolume = val),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('សំឡេងបកប្រែ (TTS)', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('${_ttsVolume.toInt()}%', style: const TextStyle(color: Colors.cyanAccent)),
                      ],
                    ),
                    Slider(
                      value: _ttsVolume,
                      min: 0,
                      max: 100,
                      activeColor: Colors.indigoAccent,
                      onChanged: (val) => setState(() => _ttsVolume = val),
                    ),
                    const Divider(color: Colors.white10),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('លុបសំឡេងច្រៀង/និយាយដើម', style: TextStyle(fontSize: 14)),
                      subtitle: const Text('Auto Remove Vocal (Stereo Only)', style: TextStyle(fontSize: 11, color: Colors.white54)),
                      value: _removeVocal,
                      activeColor: Colors.cyanAccent,
                      onChanged: (val) => setState(() => _removeVocal = val),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Speaker Selector Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.person_pin, color: Colors.cyanAccent, size: 20),
                        SizedBox(width: 8),
                        Text('សំឡេងលំនាំដើម (Default Speaker)', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSpeakerButton(
                            id: 'sreymom',
                            name: 'ស្រីមុំ (Sreymom)',
                            gender: 'ស្រី (Female)',
                            isSelected: _selectedSpeaker == 'sreymom',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSpeakerButton(
                            id: 'piseth',
                            name: 'ពិសិដ្ឋ (Piseth)',
                            gender: 'ប្រុស (Male)',
                            isSelected: _selectedSpeaker == 'piseth',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Generate Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A5F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Colors.cyanAccent, width: 0.8),
                  ),
                ),
                icon: const Icon(Icons.bolt, color: Colors.cyanAccent),
                label: const Text(
                  'ចាប់ផ្តើមបកប្រែ (Generate Dubbed Video)',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('កំពុងចាប់ផ្តើមដំណើរការ...')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.cyanAccent),
        ),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.white54)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSpeakerButton({
    required String id,
    required String name,
    required String gender,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => setState(() => _selectedSpeaker = id),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.white12,
            width: isSelected ? 1.5 : 1,
          ),
          color: isSelected ? const Color(0xFF142B3B) : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(Icons.face, color: isSelected ? Colors.cyanAccent : Colors.white54),
            const SizedBox(height: 6),
            Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.white70)),
            Text(gender, style: const TextStyle(fontSize: 10, color: Colors.white38)),
          ],
        ),
      ),
    );
  }
}
