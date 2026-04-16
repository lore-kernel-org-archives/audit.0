Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F52349B02
	for <audit@vger.kernel.org>; Thu, 16 Apr 2026 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372711; cv=pass; b=qZrEkeWiOTJxAL7VPGZc9RcDRpzAmIP52gB4u3NZZ37iUhRnDVouSh5BiXADphVhjPYVTNeyUUe4h9iuJnPEQ75R/P3+OvdeVMyG8qQNs5OJ31/r4WZhDvK5c3h5CMdKBRGJqxXzIylVCvhQJOoX0J6NYQL94H9epKi0dze/xuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372711; c=relaxed/simple;
	bh=bEp0nYeDoDo1Up/vVf0KGJLNYSq31PcCZGt4vapUOAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSnC7dcW+2CWDl3y6clwYfdTxVPMHOzW03AJSwZEsBw+k0ocXy8etpNvDQXQPBJmupNyLVNFkfZfrxR6KXASKvyqpO11A8onuOLzMfv+5Jj+ge5C/7dePuO8dsswGqchSPWJhxNDCAwWq4jdiqa71i7sUUCg4Qp3a3eJofvjtEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U69oQzYH; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U69oQzYH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso57286345ad.1
        for <audit@vger.kernel.org>; Thu, 16 Apr 2026 13:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372709; cv=none;
        d=google.com; s=arc-20240605;
        b=WYiMj9jVpXAD2NGOOtkp6fiOtDV25K+5rn/Gs6GFo79rHVZj5pCXwZZdTQpHDoNivt
         CGX5jzLg3CMP4xYEIeAIis23tHcC5XauNxfvlI9lepQqKecePRbibBw3dslmFrFmhmEA
         ykdzmJNnERfzVpX1mIzQK4Yf2jVGj6R4Dwd9cfF6Mi9ID73VH6kiRDePpZG4YkD6AnKd
         vcmsFPBUDSTcXoFHruUg3EkpGKFMUb0R2oEmvfUi8x0K/GBzecggGlI69dy4AtT3L5ti
         Xfy7zxYbvG0zuJw5BMFwLVR3HbUhcuNYt6wwzV3AyautQSqQwoc3fKaWRwil2pBPTOz1
         36IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eV96XbOoszvJ0jXq5rWAiBNPNSt/MpnljkiIEflLnuE=;
        fh=CkkjgkOq+hY8En+ca+w8BfkBgfO/VmTeVhIMdiUrVG8=;
        b=T0p+WqU0h+y4nBj9nwAEunsrd9qh8AW095BxVaUl9KqoMEyRdl576gz93nPlpxI9Yx
         uLf5fPr6i+rqUYXQZWZ0VLh75CqWCg9qzA7RX5w0ZK9nk0655p9jwljgJWQRtt0ZIiFK
         mNZ48WWkVACi3zCb3YvbUl2MLdyAdZkq6Oi6PAoCiC13uGAbKFriTVqH0UmWveiWEpj6
         WKL3VFFWpOaqzNAp9JZ4kGzb6lPs3Rkqw2S1+0xhnOQhlTu2OaPZs4mIzc7tFPLfYM+f
         y+6qOY8RamkCcxedXzuXbT+UF3bYF4IORydNODOtulvJz43rqyFI6okotRntHm6fNK+N
         KwFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776372709; x=1776977509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV96XbOoszvJ0jXq5rWAiBNPNSt/MpnljkiIEflLnuE=;
        b=U69oQzYHxv49oFxLqxr+fnSOfsBujlw/n7u+6n8s/KWp5pjGaDTtttRQJOiLIZxxKX
         zjUvMkYWyBCDJQGBljQJFJjM9A2htlPbhO180yg9wnxY27DU01I0DYOjKlAMMGz9kI1O
         I9AMB6xVEflpZ2zgDkRimxTAE/3uPM7p+l1xz/YwPyHTeV6wLCos+mUVy6WiExAG3gdt
         aDhJ6VYfZsWsIiaTqPBV8i3kNyzogMTRuKYx8Cdgea3Z4D73Zd8E8/IHnhiAfy2G8fFO
         MCHqKn/kgYQcjwL42rCXMLvhQ/6jdapASFTaRBG5W6LuqcRctTZB7EQKcReD1Eb8IlOK
         bV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776372709; x=1776977509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eV96XbOoszvJ0jXq5rWAiBNPNSt/MpnljkiIEflLnuE=;
        b=meIRf2gx5+aEjK1w8wIjMg9DcmHXdGjVaEaFc8BnqXKOn+wy5XIuv5GZ1sLVX9W3LO
         nr+vkdTKvxBE+946ENO6dtL7JEEYChfX+h9DZLQXw+jClDVp8HwpQiBgfo4eiXrrGe5Z
         Wcx45KHc46EMKmiRqUTFMX0AoYVphgdQDRH5ZlZlPEH/ggjzH7iV4rYKYHN8kJkEdG7I
         YPmZV4Ek2qdEqFRLZipfFYtek/bH2NJJapVrhtVVcqK5PBAOrtV+xgW4wADUovSqR3Lw
         uJA3l+PWqnUR5J1Dwu0zlPhzMMnXxO/wS77mrkp/8i+UWY4PBRPy9KtaXyVDqSbUimjF
         M8sA==
X-Forwarded-Encrypted: i=1; AFNElJ8k/S05pykmukkxw7D+cZqBvXbW/7MEHFipTK4OEP7ARKpBvLbrfXVGlTD/X26ft632GIxM6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUcx+RP0IhbaXP16qsMjOlbBSrMs/XhQS56be3GebwxkGtZ2P
	w+e7D7JmfVJopV0X2f4+fKqS3t/IwFwIE0P37G3nAI4AVX7phb/G7hhkY/75EDpAZaQ0mplSgk7
	ECIAhVlHE7P8/w/K6+BiHv6I4Pln92zDcngAs/8bX
X-Gm-Gg: AeBDieuUp7ILYLA4ZrRUUv/9Ldda9C9NGaQy4Miy6txlwJUAfcod4H4TspYVziAxAFN
	E2aa4wvvyE5TGPB2gYu+ce0KKP08kZ9n0vmnrJ7VHimR9Y8GVu9lxM/1iPKOC89isIF04Om/F0F
	Z0jrmUVCmptcP5w9Mcx7Is8GCw7D0qYrqWnKunol8tEF5/ilOiN+4il/lRCpr61QJmrTrDXH5NS
	KVe1yxnLW1IM5lrWyb7EazSTTa0mP4Ymaa7IiLcrGrrDekKTmT4WKWiOZSrDTIImJkBahK+ciRT
	hpxo+fr1q92HFUOOTw==
X-Received: by 2002:a17:902:f0d5:b0:2b0:5968:a6d5 with SMTP id
 d9443c01a7336-2b5f8dbe46dmr3308875ad.18.1776372709203; Thu, 16 Apr 2026
 13:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323150700.614139-1-rrobaina@redhat.com> <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
 <CAHC9VhTN+vjkSSjtfFegC9cEAcGAonYY9sNk_84_nJwLay1wwg@mail.gmail.com> <2620823.XAFRqVoOGU@x2>
In-Reply-To: <2620823.XAFRqVoOGU@x2>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Apr 2026 16:51:36 -0400
X-Gm-Features: AQROBzC_OCYKCdBWzHX_ljo2GquvKnl--5Wfm6vgRIHsBiMIkiBncIdEPgBomDY
Message-ID: <CAHC9VhSK9wsK1kDwfGGVNzRqGb6RW-_eJkcoe0uHY839OnF7Mw@mail.gmail.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 4:33=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wro=
te:
> On Wednesday, April 15, 2026 11:21:52=E2=80=AFAM Eastern Daylight Time Pa=
ul Moore
> wrote:
> > On Wed, Apr 15, 2026 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Tue, Apr 14, 2026 at 11:45=E2=80=AFPM Steve Grubb <sgrubb@redhat.c=
om> wrote:
> > > > On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight Time =
Paul Moore
> wrote:
> > > > > On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina
> > > > > <rrobaina@redhat.com>
> > > >
> > > > wrote:
> > > ...
> > >
> > > > ... compliance-driven systems that must use a finite backlog limit =
for
> > > > memory safety but cannot tolerate dropped events ...>
> > > You must pick one of those two requirements, or at the very least
> > > prioritize them; it is simply impossible to both limit the backlog
> > > queue and require zero dropped events.
> >
> > To be perfectly honest, it's also impossible to require zero dropped
> > events.  Even in the most extreme configurations where the admin
> > decides to panic the system, that only happens once the system reaches
> > the point where it is dropping events.  We try *really* hard to not
> > drop events, but it is always going to be a possibility.
>
> You're helping make the point.  Those administrators have decided reliabl=
e
> auditing is more important than system availability.

Users prioritizing reliable auditing over system availability should
not run with a backlog limit.  It's that simple.

Regardless, I'm still not convinced this maximum backlog stat alone
will solve any meaningful problems.  If your audit log is predictable
enough that this metric has value, it should be possible to either
capture the backlog size during periods of high audit load or simply
run the system through that load and verify it doesn't crash and go to
hell.  If your audit log isn't predictable, capturing a maximum
backlog size doesn't really mean anything since it is still a snapshot
of one instance of the system and there is always the possibility of
the system exceeding it.

--=20
paul-moore.com
