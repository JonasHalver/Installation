using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.Windows.Speech;
using System.Drawing;
using System.Linq;

public class SoundInput : MonoBehaviour
{
    AudioSource audioSource;
    string micName;
    public AudioMixerGroup mixMic;
    public AudioMixerGroup master;

    KeywordRecognizer keywordRecognizer;
    Dictionary<string, System.Action> keywords = new Dictionary<string, System.Action>();

    public static string command;

    public List<string> cmds = new List<string>();

    public GameObject testObj;
    bool cDefault;

    // Start is called before the first frame update
    void Start()
    {
        micName = Microphone.devices[0].ToString();
        audioSource = gameObject.GetComponent<AudioSource>();

        audioSource.clip = Microphone.Start(micName, true, 10, 44100);
        while (!(Microphone.GetPosition(null) > 0)) { }
        audioSource.Play();
        audioSource.outputAudioMixerGroup = mixMic;

        foreach (string cmd in cmds)
        {
            keywords.Add(cmd, () =>
            {
                print(cmd);
                command = cmd;
            });
        }
        keywordRecognizer = new KeywordRecognizer(keywords.Keys.ToArray());
        keywordRecognizer.OnPhraseRecognized += KeywordRecognizer_OnPhraseRecognized;

        keywordRecognizer.Start();
    }

    // Update is called once per frame
    void Update()
    {
        var c = System.Drawing.Color.FromName(command);
        print(c.R + " " + c.G + " " + c.B);
        if (c.R == 0 && c.G == 0 && c.B == 0)
        {
            if (command != "Black")
            {
                cDefault = true;
            }
            else
            {
                cDefault = false;
            }
        }
        else
        {
            cDefault = false;
        }
        if (!cDefault)
        {
            testObj.GetComponent<Renderer>().sharedMaterial.color = new UnityEngine.Color(c.R, c.G, c.B, c.A);
        }
    }

    private void KeywordRecognizer_OnPhraseRecognized(PhraseRecognizedEventArgs args)
    {
        System.Action keywordAction;
        // if the keyword recognized is in our dictionary, call that Action.
        if (keywords.TryGetValue(args.text, out keywordAction))
        {
            keywordAction.Invoke();
        }
    }
}
