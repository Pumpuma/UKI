import requests
import json

# Use the provided GitHub Personal Access Token
GITHUB_TOKEN = "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"
REPO_OWNER = "Pumpuma"
REPO_NAME = "UKI"
FILE_PATH = "keys.json"
GITHUB_API_URL = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/contents/{FILE_PATH}"

def get_file_content():
    headers = {
        "Authorization": f"token {GITHUB_TOKEN}",
        "Accept": "application/vnd.github.v3+json"
    }
    response = requests.get(GITHUB_API_URL, headers=headers)
    if response.status_code == 200:
        content = response.json()
        return content['sha'], json.loads(requests.utils.unquote(content['content']))
    else:
        return None, None

def update_file_content(new_content, sha):
    headers = {
        "Authorization": f"token {GITHUB_TOKEN}",
        "Accept": "application/vnd.github.v3+json",
        "Content-Type": "application/json"
    }
    data = {
        "message": "Update key usage",
        "content": requests.utils.quote(json.dumps(new_content)),
        "sha": sha
    }
    response = requests.put(GITHUB_API_URL, headers=headers, json=data)
    return response.status_code == 200 or response.status_code == 201

def handle_key(key):
    sha, content = get_file_content()
    if sha is None or content is None:
        return "Error fetching file content."

    keys = content.get("keys", {})
    key_data = keys.get(key)

    if not key_data:
        return "Invalid key."

    if key_data["usageCount"] >= key_data["maxUses"]:
        del keys[key]
        new_content = {"keys": keys}
        update_file_content(new_content, sha)
        return "Key has been removed due to exceeding usage limit."

    key_data["usageCount"] += 1
    new_content = {"keys": keys}
    if update_file_content(new_content, sha):
        return "Key usage updated."
    else:
        return "Error updating key usage."

# Example usage
print(handle_key("key1"))
