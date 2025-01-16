Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CDD22FDE1
	for <audit@vger.kernel.org>; Thu, 16 Jan 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057660; cv=none; b=cHZQwIrGtl6GaBS9cNb5u5aQ/zTx6gLAMlMGuzqGMqGiCMt/KY6X5ZPscKi/p3zgu54ztVvAJkhGIHdbcOKgYqdRUbtV42jBv63E0zzZtGJR3nTRXSyQAxi5nG4Exvdbc45fBM3O9huGx3QIznTSEfWLb7NhWxUcVJ3yMvR0a/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057660; c=relaxed/simple;
	bh=aNyRUhywsmzPczJNBQGJmYXIHpxb4V6Pajdsq/pBY0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmRRrzeDTCxvNs+vCa/eWyrKj45ruRR5aQjUZvYc3JIyTm4mMRuI5s4cauVlz1ZGrPco6RqfgYxoiGDw1v+TeBPAk0MntbBelGhku8JIn7miafTCdt2U6bv243b8QI/wJ+01PKVjGxvtwdy05PiuOyWaOh71qDN2VY77gCgSRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eTurk9Pp; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eTurk9Pp"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so2408277276.3
        for <audit@vger.kernel.org>; Thu, 16 Jan 2025 12:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737057658; x=1737662458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oElli+3ggihlkV4MIBIMaBF1UoQrnOocYJSICSUL6Ao=;
        b=eTurk9PpWqzMJWG7j8C17nFpR9gSiXBfX/4Il2j6nv0ofPIkSsAnjUJ4csx1opwQcJ
         3M2jEktVsmslnF05Tv7X5DfWDlvWhVdeH+P3WWkfRyGCe8H2o3G7QGc399QJ6VKpLyj7
         18FDfWHnZo4FFf9lVTBRcuxcFpeMIPx7ZmFuGlk8So2WqruLb0AH9JpnH5CYvOyTA0Rf
         F6CZuthMUqm/EdCIgBxjAK4CXhnkDzWOiiZ68hA5JtHfnrwGcMxpKkIt9wtKNf4dfjEw
         zUOhm+V0JcsiEO0ozoId22yjcNZXd+75u2X6F8VFQIWb71mb7M/fM/EeieyOka1kGdKi
         woyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737057658; x=1737662458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oElli+3ggihlkV4MIBIMaBF1UoQrnOocYJSICSUL6Ao=;
        b=gGsDqe5pOQZsJ7x3+ryUwBw5kGZownq9px++6yt/72MTahy9E6AZRxv7Q019RAwj6s
         bLmC/+4Rqf9k32nV1PaNbLW49+KLsEAgeNEJ8MI6i5TrP+pdNFUnBvv8+dyhspTaExrS
         h+0gfJVhsXf1X5Fgh6xmGrRWmO8CTVRFvQOuvQtZeit6rBBC2kM8zjb2OkO5HITVB8E5
         7okr6taGk24G8RlHvp98xFX0A2HjIduYxJ1z/4iWnhUf1hWzUXX02wZiDFEES+bxBZF0
         Jjxh5OMfLIG2SPHN2EwZAoi/s9tzcfjKs5q2OiVSzQK0VocnIC1fbxepjyEuHiirknub
         O99w==
X-Forwarded-Encrypted: i=1; AJvYcCXazPcQFu8WlXb6hnUk0h6glphB/nPZ3vS9GS15CkFiCZ+ckmEgX6lkNdPI29cVq6fXl2elVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjLQZha4MkkPPVzbx0Ssp9c1g5pW6NqpPJ6tn4jBjzwRKDgS5
	ikTfXTZt07L0dMrqavH1UQVrF6+h7wlWVIa5/oSEqO+CRH3fekIRaScwV3aaV5Gy8ESEvweTLlz
	SeUdOYKtKg+/+boXvWpcYNAO6WmRfDGCsK8Rc
X-Gm-Gg: ASbGnct7quxsfsRmb8hKhFJY940nOoT/XKmf9DbFm9/XOdBmCmeBqw8qYB/eA/iWbT7
	dQS/67BkzmlDq9psDBqZgbLehHyf0BEqszKAd
X-Google-Smtp-Source: AGHT+IGl5v00tP6+s4EdDRictlaMoyFdHumztxdoWGQGQtVu8+cj4GjC9HAYJT5FcoH7A/7dJR6m9ZzuUhziC+7qmbo=
X-Received: by 2002:a05:6902:114c:b0:e57:575c:4fb1 with SMTP id
 3f1490d57ef6-e57575c52d3mr14768054276.13.1737057656511; Thu, 16 Jan 2025
 12:00:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108154338.1129069-9-mic@digikod.net> <081bd4a2a44a80e046662667e0aeb309@paul-moore.com>
 <20250116.gie7theti7Ji@digikod.net>
In-Reply-To: <20250116.gie7theti7Ji@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Jan 2025 15:00:45 -0500
X-Gm-Features: AbW1kvZnLp909a2qe8e4eDA3jcs0QClLlN2iqkkhiaLue5AKbxdXCSe-BgME1fw
Message-ID: <CAHC9VhQhUJO-yNz795TP-DqP8d+qNDeD8fJzUg_QO365r_J17g@mail.gmail.com>
Subject: Re: [PATCH v4 8/30] landlock: Add AUDIT_LANDLOCK_DENY and log ptrace denials
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Jan 15, 2025 at 06:53:06PM -0500, Paul Moore wrote:
> > On Jan  8, 2025 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:

...

> > > The next patch
> > > series will also contain a new kind of audit rule to specifically
> > > identify the origin of the policy that created this denied event, whi=
ch
> > > should make more sense.
> >
> > Generally speaking audit only wants to support a small number of messag=
e
> > types dedicated to a specific LSM.  If you're aware of additional messa=
ge
> > types that you plan to propose in a future patchset, it's probably a
> > time to discuss those now.
>
> The only other audit record type I'm thinking about would be one
> dedicated to "potentially denied access", something similar to SELinux's
> permissive mode.

In this case the "audit way" to handle this would be to add a
"permissive=3D[0|1]" field, or similar, to the AUDIT_LANDLOCK_ACCESS
message.  If this is something you are definitely going to add to
Landlock, I might suggest adding the "permissive=3D" field now so it is
present from the start.

--=20
paul-moore.com
