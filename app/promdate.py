#!/usr/bin/env python

import os
import logging
from flask import Flask, Response
import requests


logger = logging.getLogger(__name__)

app = Flask(__name__)

@app.route('/<path:subpath>', methods=['GET'])
def gets(subpath):
    """
    assumes the path is a URL without its protocol,
    then fetches the URL and returns it.
    """
    logger.info(f"proxying: {subpath}")
    url = f"https://{subpath}"
    r = requests.get(url)
   
    return Response(r.text, mimetype=r.headers.get("Content-Type"))