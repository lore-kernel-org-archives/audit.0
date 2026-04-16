Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05138E11A
	for <audit@vger.kernel.org>; Thu, 16 Apr 2026 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373113; cv=pass; b=W9bEW4BVWaKJw5H1lyoM2LLjJlNMR99q0i8wRK4iYHoVmUhNM48PvrGmI35Cf2sN09wj1rgZYQ2b+AelYBq5C2XzZ3lKpV62YHxa1PBSGnX4asZSdbEvDFBmt0aTxQ5dSU2avZSDigXxFQN2AUu9kXxf4v0s86yhla+3SxZ76x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373113; c=relaxed/simple;
	bh=gXlr/JSfD0502yKyc9t5QAc45mn9H9itpZhHpMpt4rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IClJFDkN2xEF3nrk0U+55dE3UV/9anaGlZcQzyoz9BQDxbjy3SBh+rsI3jJDjMNOlzj8YoZkpM3wetuV7c0CbUzdqrgi2Q6CkC7HHRT5hIy/QKwHspUQi20IFukdB3K/Y0HD9CrKWOpGLxy5KdQNb335vwp9R8tSDojqTkObJZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LAqmll3y; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LAqmll3y"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f4c3619b0so6969b3a.2
        for <audit@vger.kernel.org>; Thu, 16 Apr 2026 13:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776373111; cv=none;
        d=google.com; s=arc-20240605;
        b=BmeBQI6jWYQH+VyfzLtuYyeH8RvVc+tG8MznKArLBmSue0dfnfQ1gEp1Qh4UMeefOn
         OIZ8Y4zDF4rYCKtcg1YsOPLVw/XElRxbj8alNPzZ04D0lIDtactyaKt7JsexeDXWv8/G
         hTntmIzqBlUFz0TQz1z8cMO9loq+7x6VM+5W7yeqGmnoKGFpYT1aR7xmCg8NjL5ArqZp
         ZBAgTdXCHvg9FeTA0meHUYusJdG5PC5NrLabI9m26Aliy6lOSL5EJ0z2NhhWxI/eV8vn
         wmVbBH6LH6XSbxZi05Hc/LulKyeFpLJy+C3A+9FO7IMkeSsII1Vh+WK0+C3iwd5GEB/i
         fwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YoiXcIHKFCiYT+GWlO+LrWCsep6cNUVXCWnCv6V1MRw=;
        fh=z0oE4su7tC3IUC5Qh24XCQCVPdVgyn/df7jVQri7BaQ=;
        b=AlidMZEyCSngbdc9noUI4W32vkuHHEXtupSGkZ0d3jPgGN+a1dgKhSuFcoBQJAexdE
         /9SSL3QArMFZ/DYY4558+XMXnDHv7nK1C0/skFilqOOuQRakCAOWRfbhBfGYWjhBESQy
         OkkJQ6VY8AmcfA+42+eEn0WVso5bwVC/sVtzv8/zoZLvwrIpTzmSUYCvUOPaj4TgLkP/
         XOtJyKrB9qOCVUuO5m2BjZeoQwFiO+u0MqYsPz+5UdfhDMTnXYbjA9sTbsAOPV1zTqVP
         KP7D4O22y5QYWOBmaNal+ODnnks2NbE+NiwiFMq1OyCxbGI+nommileE7WdfFqps1DZd
         siQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776373111; x=1776977911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoiXcIHKFCiYT+GWlO+LrWCsep6cNUVXCWnCv6V1MRw=;
        b=LAqmll3yg0SLsLf8BPPxNm7G/Rc81aoyDMSb6NRsuzVv2wB0BZxMxdYVXBbc5cxTnd
         wAEGmJjioOd0RbvP9x1gm7t3oYZGiWYDiHDRM5OyXKU2wMotAC/HLqf7RG7MChj+oezP
         3esfI/ZD0IqstPx43q3kvAPgUf3BQPCHKP+5F79T9ut4jALBEq2vssmombIuzFCV5o2J
         1JmbDRuBcHtzG6xFSlaCQE1iDy6sbCuaWKOoHNwGgNTHP6DZ623F/cckzla0134z6zDF
         LCQ/YKtxXAfwYZBYItPyl/7Y3V7m4a1NLoUqQYjNgzQsU3NKk4coqS6H6JO5X1VLDlN4
         zNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776373111; x=1776977911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YoiXcIHKFCiYT+GWlO+LrWCsep6cNUVXCWnCv6V1MRw=;
        b=m2ChgGiXqttWEkpBCF/Yja+V6ito6x2nH+JybsC/KnnwayKDot67XZe60Wm/OcEq74
         GhNHcOj355USGCECpadVYN8I/WqskVs26SfshN2nWXgDzl+rhMZQAeUDS+sxm8KEfoT3
         kgVYweZ6zyOlDPWQAoGNfBAeD/Oidd5wmxITRNjQ3LxfOS1jRIgcpqoVezQm7JLsjpf7
         J/plLVoDSOB+BLomi077eRm9jRXtAvOmnf2JP91AYLSbrKiLEZhodKYKtI6M2UKu2z1d
         reSoGERJJNPxMA1vDfyxwLMtvljWCOFsBWWKn8e43UfSUj8wfhYlrAySovbwTkVBp9y4
         T+Tw==
X-Forwarded-Encrypted: i=1; AFNElJ9W0YYP6IfSEVJRSevAyjMms49ksbo5WSWSUD8eRpLk+jiC48/6V1jHgtaIeioDDP3nKfhMOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVUaVnRrrLFMl9zM4k2uk1Fe6yJTZPf2TlEoMkwuG/LFSak3j
	OlT+kinUgySzF7u3HTwOeYxRmzDxYhKUr5g2JqX2v0AGvXag5LvQE5K0D8OD2H985xXn6mrtT3d
	s61b+Qil4kp3me34EJr+KFGZbdcDHWl9ZmYngOPJm
X-Gm-Gg: AeBDiesBcsSGqU78/FkXY2emdz8vdTCLSGDjuKTcbhxz+C0UpZXHhs7ra75A5it2Fs2
	M8MkD6S7roFc+Cvzf+COkorHUQt0T7yIjIJvuvBiKV3v3TZ0BQOqaKFzAAcuxm1oUeUJPYjaG+W
	RBAA8vsHLkK8NNl7RyVyDcFtQvVI9UUy6lXkvnFVukKt8Wy3KcF6/hyumcVP/ZNIjkJ3oAHwZbT
	vAIDZHBu/OD3/lyIs2sF8wF0M2LAhi/Du2y7PmG928+E2GByrPQhE+Gh/iKXg69NKpoFbLipAXB
	c5vsrchjIoenNGb+qg==
X-Received: by 2002:a05:6a00:a586:b0:82c:66f2:1226 with SMTP id
 d2e1a72fcca58-82f888e5debmr841629b3a.38.1776373111405; Thu, 16 Apr 2026
 13:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323150700.614139-1-rrobaina@redhat.com> <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
 <CAHC9VhTN+vjkSSjtfFegC9cEAcGAonYY9sNk_84_nJwLay1wwg@mail.gmail.com>
 <2620823.XAFRqVoOGU@x2> <CAHC9VhSK9wsK1kDwfGGVNzRqGb6RW-_eJkcoe0uHY839OnF7Mw@mail.gmail.com>
In-Reply-To: <CAHC9VhSK9wsK1kDwfGGVNzRqGb6RW-_eJkcoe0uHY839OnF7Mw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Apr 2026 16:58:18 -0400
X-Gm-Features: AQROBzAuk609xBDWIshUwZ1BpaVNELgYDU6VDJlDHCcL1giyoNIb8qo4352hLzk
Message-ID: <CAHC9VhTPPJmq9ezyi=KB+E+UfoTZA69QMfk79xGjG66pZx73XA@mail.gmail.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Apr 16, 2026 at 4:33=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> w=
rote:
> > On Wednesday, April 15, 2026 11:21:52=E2=80=AFAM Eastern Daylight Time =
Paul Moore
> > wrote:
> > > On Wed, Apr 15, 2026 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On Tue, Apr 14, 2026 at 11:45=E2=80=AFPM Steve Grubb <sgrubb@redhat=
.com> wrote:
> > > > > On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight Tim=
e Paul Moore
> > wrote:
> > > > > > On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina
> > > > > > <rrobaina@redhat.com>
> > > > >
> > > > > wrote:
> > > > ...
> > > >
> > > > > ... compliance-driven systems that must use a finite backlog limi=
t for
> > > > > memory safety but cannot tolerate dropped events ...>
> > > > You must pick one of those two requirements, or at the very least
> > > > prioritize them; it is simply impossible to both limit the backlog
> > > > queue and require zero dropped events.
> > >
> > > To be perfectly honest, it's also impossible to require zero dropped
> > > events.  Even in the most extreme configurations where the admin
> > > decides to panic the system, that only happens once the system reache=
s
> > > the point where it is dropping events.  We try *really* hard to not
> > > drop events, but it is always going to be a possibility.
> >
> > You're helping make the point.  Those administrators have decided relia=
ble
> > auditing is more important than system availability.
>
> Users prioritizing reliable auditing over system availability should
> not run with a backlog limit.  It's that simple.

To clarify this further, even on systems without a backlog limit and a
panic-on-loss configuration, there is still a possibility that the
system could lose an event when it hits the edge before it panics.  A
maximum backlog stat won't help here.  Even if you had a way to
capture the backlog size before the system took itself out, the size
is flirting with the maximum resource limits of the system, it would
be silly to use that as a configured backlog limit, you would still
want to leave the limit at 0/disabled.

> Regardless, I'm still not convinced this maximum backlog stat alone
> will solve any meaningful problems.  If your audit log is predictable
> enough that this metric has value, it should be possible to either
> capture the backlog size during periods of high audit load or simply
> run the system through that load and verify it doesn't crash and go to
> hell.  If your audit log isn't predictable, capturing a maximum
> backlog size doesn't really mean anything since it is still a snapshot
> of one instance of the system and there is always the possibility of
> the system exceeding it.

--=20
paul-moore.com
