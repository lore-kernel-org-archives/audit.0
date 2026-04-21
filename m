Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B403A75B3
	for <audit@vger.kernel.org>; Tue, 21 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809430; cv=pass; b=Vx4pDuYMndR6Dl4CBfuvm20xTlRO1QJvqi7UE92EbSNTAoA3TVjR76T45j8qdVkv9/HfQBJvNHEiTi3TLb4EvVik+n6WzwlzEkfBHx/UxJOXvfvjoA2j8FKsKTcPbyIG7U+VR0nDVrEQ5aSn8P7UxDTl7G3E3y/FJB/HaEPqzxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809430; c=relaxed/simple;
	bh=xFXFGWyulzpS5kgQ1H2MDTMFPA/U/219DnWbJY3bqbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxR0qEblXmsvHJutbJgiNIDSz1EDWL6xkW80S2loy5EBfc/ImPFp6XrfpOmeTBY7c2nZmRoI2yXwzgzGKrnbeMDXtb7+Vz5dP5vjRh09nZHy3y5dVKkKk60Ad8d2IraRy6B3DOFe9X8mJNsPoBhQ+itXy8+rxTmPOfXOoybMq20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CymeQB43; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CymeQB43"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1901491a12.2
        for <audit@vger.kernel.org>; Tue, 21 Apr 2026 15:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776809428; cv=none;
        d=google.com; s=arc-20240605;
        b=J+W9VwExkJ8QZmnr8JFuiTs3hexIHui/WF6PANSAMDwmdh6tF0DtFDPuUQb7AzJ2EH
         nF7WvDEficGU0iMVIg/RWFuUakr9TcXqMxUiYgBdPW/GW8Wozh0e5uU75lqrkCmqTnz9
         q4zx/w1jKUo0ng9xsZwrWhDx7gmVcL1LYSY4teVfGA8p9eJ7p7dvJSc9vf+zZ7hb8Am9
         G6Vyab+29cysbq7anb/ovy43JDosuoIjiYPl/nr0u0oddsbFgRNj6cGMZWxBZOyXXJFz
         OiPsfYeutmNtpmK5Xv9jyfbZrGKwazA/Q/nuwpd7NDynwfB8BUBgZFj5x0OuB1pkgeL6
         XdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        fh=e/TgDEQ6eBsTbg9B3+PNHEhqyVXnvMpsBeVXJwy9Wxg=;
        b=AteQbja83JA5N5TQoHxrE6Ul3wzZRJtlsdoxI1k6xSrFX/Qni7bbnk9A/BUwI5iZrt
         3+2gTJkFLlbJ3fypvmw/W6nQ832QcnjkeAzImQhFTM85JJKg/0Jusf4dxvp6Qy3kK5UF
         1jaGFQDD3wJXyjGCD+KFMvZj4ilwX5VMuGRYFzr2sqtJUYGct7Tybp6g1N60j603dnbF
         e2BZRtTCVnaKBZInhQqOJHFb0U56nDJXC/YqPFqtIzK4UhGcKWAZXdWk8mdb8eQplzHV
         PflZA/QRYmUME7Gln6wyaLG0xR9JYYUgab1GgBTVxSrnK1ORNbO+HPkBWeSXEPjP9IGG
         8Uog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776809428; x=1777414228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        b=CymeQB43g+xgXJkvDnYkNZWs7GQqQn1p0+1Mp1dP+MUiiv2jL58H8azLIiUlG+C0CQ
         oVKVMDkL6kmEZJDJ0Al1sF5svSL5adj6rMz1Ie+h9FNhm+DTGzUW7USpBsRaI9Fit8Dm
         vVJRWetTHq/Zlx104bdtYXQZwnM1ALCHL6Ctr6y2TFxEtxpBKRkVRcGeDe7a18igmPbA
         OZqoHjQXWEONHQzAf+ftKhWbI8IUuf/VvuS5Vz/dFmUjQOcDMWaLXmcdi8vks5J8lExi
         LmZ1AlOdF+vfRsCjqb8V5ZrC9Ea8TeMNY+Gw2Jrka+cQzaOeRFx2iA6rpZ31/Eg70bcg
         6r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809428; x=1777414228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        b=qpYkJ6ahm7wxqoNYpQHeEz6M2+PQL6ao00cqZtxnJ+JpZru/yFKh9pmgqt65kNAwyf
         DEecFxAqQ9wbkfF6ROw668vonqM+EW4KygHPF/Jy5Dj27Ah2R4NolybNRllWoR+yb/zf
         wS5Hyd+eGobnU2iKujdmcpndtre3F6owXS4IdnI3f8Qol8odjZ5Amzgf7C0wNlL9mDM9
         k3AOI4AXoaYXaLpUsjDSR3lGPZwoZ1bCbbuLdgJIV8pm/mLQxFnB/yrNjQp3hMfFX/Cp
         CitbQbeDI/T4oIwq/Oh9JQWdmaTZCaugErX6VnXG/wbcWmT7aQFaQ4T+oK2BqR8egLPM
         KpYA==
X-Forwarded-Encrypted: i=1; AFNElJ/C3Xfukkt9m8hvPt/stNOI1QLPQyMttrtlvY7VUiPkSCvxkSfXnrNQoE5uso9hSKIy6en3ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyde47U/HMC3JIWTOY5WMEh/mbb+wg9U5PEWrXmFT3bWPK6lNGr
	jeSEahKrmaEd57Ifv916SbHFPAu0uL8aPKfBAKLpdzwqAvpGDGtJkRxa8EYfsmbTs7Nei7ipsvC
	xGxRcwMB2f+zyX86FlcKVXLyKeSqfVmzIWYZAyFXk
X-Gm-Gg: AeBDiesu7kRMxdbQkdv1bDNSwNnyJ5Vnfq+y/ZkAuQAE+tWgY/pLzJEh1h9lC5wpkOB
	r7JEBMxjXnfFNVRdG3qa/ep5dO/aHJ8hLKv98n34T9VRonxDhu7Gh1RXAHdZjdZv3oj23H9V2Rc
	1I6amM9DFX7KFKbzt265NF3pJav8RRK9fwwXqoBz1a1XEifXC0KaYyw2RwJwzGHckpxmRrbBzBC
	ZZW2wJd+Qankt5VtjGbms7UffRlf4gRTPAT7QOFgZuKyqb/3O2wjQaQ5k1cRXYLXbz2gvUDWVCZ
	7sMAedaLjtiD7CzC+oE4cbGCcKmE
X-Received: by 2002:a05:6300:8088:b0:39b:8dcb:f37d with SMTP id
 adf61e73a8af0-3a08d716acemr16416581637.17.1776809428374; Tue, 21 Apr 2026
 15:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
In-Reply-To: <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Apr 2026 18:10:15 -0400
X-Gm-Features: AQROBzAZx6KqlUgLuc6SEp8mHgK0_7ru1fA894kSMYQ0Oc1ORPoRRj_U35eYYmo
Message-ID: <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 2:07=E2=80=AFPM Frederick Lawler <fred@cloudflare=
.com> wrote:
> >
> > Hi folks,
> >
> > I was accepted to speak a little bit about this patch series at Linux
> > Security Summit this May [1]. I'm going to use this opportunity to
> > re-iterate some of the motivation, what can be done today with BPF,
> > drawbacks, and wrap up with discussion topics. I'd love to hear feedbac=
k
> > from audit, BPF, and security folks to work towards a viable solution t=
hat
> > addresses shortcomings to allow for better integration with BPF.
>
> I don't think any bpf folks will be there.
> Also giving a talk about it doesn't make it acceptable.

I think it's valid to have a discussion with the LSS folks as they are
the ones who will most likely be interested in using the
functionality.  From my perspective there is still value in validating
the basic ideas in Fred's patchset and checking the value amongst the
LSS audience.

> It's still Nack.

Based solely on the diffstat and a quick look, this appears to be an
LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
but they are LSM/audit kfuncs and not core BPF functionality.
Regardless, I want to see how the LSS presentation is received before
worrying about this too much, but your NACK has been noted.

--=20
paul-moore.com
