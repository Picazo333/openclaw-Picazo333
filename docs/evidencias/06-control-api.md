# 06 — GET de control directos a la API (solo conteos)

```text
user/me 200 academias []
PROJECT tasks 200 91 task_status {'DONE': 27, 'PENDING': 64} revision {'APPROVED': 19, 'PENDING': 72}
PENDING 200 64
Traceback (most recent call last):
  File "/root/aulaclaw-evidence/groundtruth.py", line 15, in <module>
    st,c=get('/v1/admissions/academy/cohort/me'); c=c['results'] if isinstance(c,dict) and 'results' in c else c
  File "/root/aulaclaw-evidence/groundtruth.py", line 6, in get
    with urllib.request.urlopen(r,timeout=60) as x: return x.status,json.load(x)
  File "/usr/lib/python3.10/urllib/request.py", line 216, in urlopen
    return opener.open(url, data, timeout)
  File "/usr/lib/python3.10/urllib/request.py", line 525, in open
    response = meth(req, response)
  File "/usr/lib/python3.10/urllib/request.py", line 634, in http_response
    response = self.parent.error(
  File "/usr/lib/python3.10/urllib/request.py", line 563, in error
    return self._call_chain(*args)
  File "/usr/lib/python3.10/urllib/request.py", line 496, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.10/urllib/request.py", line 643, in http_error_default
    raise HTTPError(req.full_url, code, msg, hdrs, fp)
urllib.error.HTTPError: HTTP Error 403: Forbidden
GT user/me 200 roles [(7, 'online', 'student')] cohorts en user/me 34
GT cohort/me (Academy:7) 200 list 2
  keys ['academy', 'available_as_saas', 'current_day', 'current_module', 'ending_date', 'id', 'is_hidden_on_prework', 'kickoff_date', 'language', 'micro_cohorts', 'name', 'never_ends', 'online_meeting_url', 'private', 'remote_available', 'schedule', 'shortcuts', 'slug', 'stage', 'syllabus_version', 'timeslots', 'timezone']
   [('latam-pt-73', 'ENDED', None), ('latam-pt-70', 'ENDED', None)]
GT user/me cohorts [('latam-container-applications-with-docker', 'ACTIVE', 'STUDENT'), ('latam-ai-engineering-introduction', 'ACTIVE', 'STUDENT'), ('latam-coding-fundamentals-with-python', 'ACTIVE', 'STUDENT'), ('coding-fundamentals-with-typescript', 'ACTIVE', 'STUDENT'), ('working-with-ai-coding-agents', 'ACTIVE', 'STUDENT'), ('command-line-git-github', 'GRADUATED', 'STUDENT'), ('web-ui-fundamentals-with-tailwind-css', 'GRADUATED', 'STUDENT'), ('personal-assitant-with-openclaw', 'ACTIVE', 'STUDENT'), ('latam-pt-70', 'POSTPONED', 'STUDENT'), ('advanced-personal-assitant-with-openclaw', 'ACTIVE', 'STUDENT'), ('latam-pt-73', 'POSTPONED', 'STUDENT'), ('latam-ai-engineering-fundamentals', 'GRADUATED', 'STUDENT'), ('latam-intro-to-4geeks-method', 'ACTIVE', 'STUDENT'), ('automatizaciones-no-code', 'GRADUATED', 'STUDENT'), ('latam-aie-pt-6', 'ACTIVE', 'STUDENT'), ('desarollo-backend-con-python', 'ACTIVE', 'STUDENT'), ('latam-coding-fundamentals-with-typescript-v3', 'ACTIVE', 'STUDENT'), ('latam-working-with-ai-coding-agents-v3', 'GRADUATED', 'STUDENT'), ('latam-coding-fundamentals-with-python-v3', 'ACTIVE', 'STUDENT'), ('latam-application-telemetry', 'ACTIVE', 'STUDENT'), ('latam-ai-engineering-project-delivery', 'ACTIVE', 'STUDENT'), ('managing-relational-databases-with-fast-api', 'ACTIVE', 'STUDENT'), ('error-handling-debugging-testing', 'ACTIVE', 'STUDENT'), ('latam-secure-ai-applications', 'ACTIVE', 'STUDENT'), ('authentication-web-applications', 'ACTIVE', 'STUDENT'), ('latam-implementing-data-pipelines', 'ACTIVE', 'STUDENT'), ('latam-real-time-communication', 'ACTIVE', 'STUDENT'), ('latam-agentic-engineering', 'ACTIVE', 'STUDENT'), ('latam-agentic-workflows', 'ACTIVE', 'STUDENT'), ('latam-architecture-optimization', 'ACTIVE', 'STUDENT'), ('latam-models-training-rag', 'ACTIVE', 'STUDENT'), ('latam-asynchronous-processing-and-offloading', 'ACTIVE', 'STUDENT'), ('latam-frontend-development-with-coding-agents', 'GRADUATED', 'STUDENT'), ('backend-development-with-coding-agents', 'ACTIVE', 'STUDENT')]
GT activity/me (Academy:7) 403 str {"detail":"You (user: <user-id>) don't have this capability: read_activity for academy 7","status_code":403}
--- 2026-11-11T02:55:46Z
user/me 200 academias []
PROJECT tasks 200 91 task_status {'DONE': 31, 'PENDING': 60} revision {'APPROVED': 19, 'PENDING': 72}
PENDING 200 60
```
