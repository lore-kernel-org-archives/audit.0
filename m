Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913942E11BC
	for <audit@vger.kernel.org>; Wed, 15 Apr 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266378; cv=pass; b=S3FDvMiGgPK9UtVgIF76F+FOLzkuza90r8WgYQ+LDDVnzR7NQdZ9LIPWxgu4n0qDvRx7PGTd+ToPZjfYNx+8Fp2gbo2ta1eXev7oxyX//zKOvGK6akqIgtrUDqv+3PD0woTEJDEaplkJHGDD5PAK52narR6v6TvLm3v+TQ7mbGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266378; c=relaxed/simple;
	bh=7KrMP4lRGQ7qKMe9fVsmrNjhAVvnL/c0u6hJgjV04F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jS5paqGRe0W1GnvqexHWvCn9BKcFWnfUpY7s3mZc7eM9Jjtxb4aFZ3fL74JymEqyO21FaVV/DV58NmcPWCe1YNqw2KlfArnxGendhVWcIgbwiBotEH3d387HrWqW9vTvGpqyfiweHxkToStMuhCImOphcrXV1LnORXtYsFZfZjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gRZR0fmd; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gRZR0fmd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso2465521a91.2
        for <audit@vger.kernel.org>; Wed, 15 Apr 2026 08:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776266377; cv=none;
        d=google.com; s=arc-20240605;
        b=SKQ+9Mbvy3QoCO2HJEgUUl5NrjoMnfhjZYiFT725kG6w1o4Mx3EyBO7ZoMuyEhIYdr
         9WUzO5ezKOI9OLJtOSvBtmy9DBb8CyjT4b1JIAGLjIItMQtIZPmT1n2vHb2eQvdFXvaa
         abqdxLefhAQTj/XxehFUaOqDxdYxMEmL8J+ivBHKYd4nIy3VAXRH5znqTnkMt2GtbNaG
         4eY/ciD7v2G+oyU4yGd8GxYua2PSbcyEgzDSx83TCPk520H3ajr236Xba6Q5fjTJu3kg
         M31z00wyO5DF/1hyx34ZS50DcHXSphMC8/WTW4qwFYEgIsL796jE8vV8rGj+cBUWQ4aQ
         2DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7KrMP4lRGQ7qKMe9fVsmrNjhAVvnL/c0u6hJgjV04F8=;
        fh=yXNJP4QXyPSjn87lYBCEaZorLbSPCZBX71k2IXwbtis=;
        b=kL2tVcQUefnOSYo+Krvhaqr9byR/iEcFaqjq1ksfloPi+SwB1eM/eixGpqqQ7lMOcj
         cw3F7zBuNrhchpHpeWyDkisPTpqMKzREnmyTbvu0WSbj/9vJUZvs1P9a66dKhnIv2NBl
         6CBxvxiIRrbWxfPSocwNxeRPEY5OFKyf653nUx32rkRa6jLjobk56QfXO+gGc7/tn4pC
         Y8q0z4fDXIHioqLt7eVPxeOCcTHzeb8ndCEz4p3laLaPsHng2mq4MHLRuYfg8QSF9XLR
         2SS+DJRQ3azJLTxummVzAHhOygR2u0bauA35y9n2QkuYt2hftBZnWFYOh6gA0PCl0VGm
         zLXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776266377; x=1776871177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KrMP4lRGQ7qKMe9fVsmrNjhAVvnL/c0u6hJgjV04F8=;
        b=gRZR0fmdq+Tgcoo3C6Pn49qZDeFEg5rN61lHK9z8GPiQXvnSGYW1ZMjz56R+k/4okz
         cQmnWRGFAjqlzFRPHLtwRxo4XXWQ6y811uIbd14BeLOyerw5I98nL3n8sk/7wf/BHuXI
         CSM0BUvBzxf44E+71JL/rdS4gUCnk/YNghUtNE1+3MB4y8tfs4g2YUU+6usWHyZ2MjFr
         NYHWF18pBkQAMluH1GmOuyUGJO1wmLH8CeVXtVPyF0Purfkg7SN5uIe3tgkYbMKIHfUN
         C6jd/SbtdoMhkUa3mgr056G7iZMaC4uJymEjvKFlg9NqZ949/vOmau6yYdHLxeXL4yW+
         PMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266377; x=1776871177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KrMP4lRGQ7qKMe9fVsmrNjhAVvnL/c0u6hJgjV04F8=;
        b=H48Xf0WWb3QJCFhr8DssxNQQxH46KN7b8N72z9VooqEec6LfuYbSJsfHYOZA6qg5fx
         sMJ1aeb2zWiBEQmfmDhw6JR/mPYF1YORxVEHEpmsL2XbsRIrU94KtItj8Sf+hpuRc8vH
         jnbfISevAKJG7yK/y4i1BbrLykLkCkICMLe4n+cqB+4hMREHZ3usmjfBkP4wnvDSf3C5
         CXuG1EBWsGh2HcNtBPkMg1r428NVFCtucCrJQ12+ErpkKEhp4nLhtjUwi6mtlRedBz8n
         cUW1P46GCL3duE+0zmUNizZhVdYmVkQdixUCV4xa1TK76zLKO0/R0o2Bea61qAeYFvep
         YCzg==
X-Forwarded-Encrypted: i=1; AFNElJ+cHayrZQDFPZpTBdDE87hiQyP78ma8rVbiTPZ2CYGkYwFP59oW1g786E+LKRsPyw0dy03y0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4kkFkUgYJHS4RmE1zRVwC+cqknIeMO4dQD5fGnPPD8LmtF7e
	eqHFVHNR2XkQ5aFVflYidOwUM6+sJFRMoNYaWJhqilT4bz98gRR6i1TPUMJTko0E+UK2/F2iy1F
	Y070+IE0m3RvqJ81TP/HlpI6HOm6d0NpNb8eQUwWv
X-Gm-Gg: AeBDieugJrEyuhxu5AZvIsM3vbIbqYdnmbY6Ut1nlr7Tu9grbOIzdvOG/IC5O3QdL3E
	632nnt6y0VowF7h37LQSGpwPzOPsoRkGAu3G2gNV2LniPlybGtHwMJcehiJLYKvivvd64otx9Cj
	ixtFy95Li4SwjLRgtTgmUK4led4Jot8F+bjBuzoY99M5SB3Y2PobqK0wzz4e+xkr9dkwOLAyM4W
	RhOVr+M/U8ccPReoplv4rccQGBmeUaPSP5OGhifF4PwvfAwLPTOJhceIRL2TmvNgDmVi16P4eZv
	RpdmLRk=
X-Received: by 2002:a17:90b:3b46:b0:35b:8d89:7199 with SMTP id
 98e67ed59e1d1-35e42853381mr23062281a91.15.1776266376930; Wed, 15 Apr 2026
 08:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323150700.614139-1-rrobaina@redhat.com> <CAHC9VhQTGfuOYev_UNzwSqUoYX-y+RYyMZgWWG2eGzM62eVm9A@mail.gmail.com>
 <2213475.9o76ZdvQCi@x2>
In-Reply-To: <2213475.9o76ZdvQCi@x2>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Apr 2026 11:19:23 -0400
X-Gm-Features: AQROBzCTVU3TuzuxyybirmVqIK3_TyIOi4OwyXlWIoncpOuJIQNmiRedfB8JVZE
Message-ID: <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 11:45=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wr=
ote:
> On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight Time Paul M=
oore wrote:
> > On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina <rrobaina@redh=
at.com>
> wrote:
>

...

> ... compliance-driven systems that must use a finite backlog limit for me=
mory safety but cannot tolerate dropped events ...

You must pick one of those two requirements, or at the very least
prioritize them; it is simply impossible to both limit the backlog
queue and require zero dropped events.

--=20
paul-moore.com
