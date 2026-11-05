#!/usr/bin/env python3
"""Translate the untranslated (and fuzzy) entries of a .po file with DeepL. Provide the API key in the env var `DEEPL_API_KEY`."""

import argparse
import os

import deepl
import polib

BATCH_SIZE = 50


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("po_file", help="path to the .po file (modified in place)")
    parser.add_argument("--source-lang", default="DE", help="default: %(default)s")
    parser.add_argument("--target-lang", default="EN-US", help="default: %(default)s")
    args = parser.parse_args()

    po = polib.pofile(args.po_file)
    todo = [e for e in po if e.msgid and not e.obsolete and (not e.msgstr or "fuzzy" in e.flags)]
    print(f"{len(todo)} of {len(po)} entries to translate")

    translator = deepl.Translator(os.environ["DEEPL_API_KEY"])
    for i in range(0, len(todo), BATCH_SIZE):
        batch = todo[i:i + BATCH_SIZE]
        results = translator.translate_text(
            [e.msgid for e in batch],
            source_lang=args.source_lang,
            target_lang=args.target_lang,
            preserve_formatting=True,
        )
        for entry, result in zip(batch, results):
            entry.msgstr = result.text
            if "fuzzy" in entry.flags:
                entry.flags.remove("fuzzy")
        po.save()  # save after each batch so an interrupted run loses little
        print(f"  {min(i + BATCH_SIZE, len(todo))}/{len(todo)}")

    usage = translator.get_usage()
    if usage.character.valid:
        print(f"DeepL usage: {usage.character.count}/{usage.character.limit} characters")


if __name__ == "__main__":
    main()
